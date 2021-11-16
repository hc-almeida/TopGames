//
//  GameListViewModel.swift
//  TopGames
//
//  Created by Hellen on 13/11/21.
//

import Foundation

typealias GameListResult = (Result<GameListResponse, Error>) -> Void

class GameListViewModel {
    
    // MARK: - Private Properties
    
    var gamesList = [GameListCellModel]()

    var currentPage = 1
    
    // MARK: - Public Functions
    
    enum State {
        case loading
        case error(error: Error)
        case loaded
    }
    
    var currentState: State = .loading {
        didSet {
            stateChanged?()
        }
    }
    
    var stateChanged: (() -> Void)?
    
    var stateDescription: String? {
        switch currentState {
        case .loaded:
            return gamesList.count == 0 ? "No games founded" : nil
        case .error(let error):
            return error.localizedDescription
        case .loading:
            return "Loading games.."
        }
    }
    
    func loadGames() {
        currentState = .loading
        fetchGameList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.gamesList = response.games.map({GameListCellModel(model: $0)})
                self.currentState = .loaded
                print("========= response viewModel: \(self.gamesList)")
            case .failure(let error):
                self.currentState = .error(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
      
        let downloadTask = URLSession.shared.downloadTask(with: imageURL) { url, response, error in
        if let error = error {
          completion(nil, error)
          return
        }
        
        guard let url = url else {
          completion(nil, error)
          return
        }
        
        do {
          let data = try Data(contentsOf: url)
          completion(data, nil)
        } catch let error {
          completion(nil, error)
        }
      }
      
      downloadTask.resume()
    }
    
    func downloadImageWith(urlString: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        download(imageURL: url, completion: completion)
    }

    
    // MARK: - Private Functions

    private func nextPage() {
        self.currentPage += 1
    }
    
    private func fetchGameList(completion: @escaping GameListResult) {
        let url = GameAPI.build(page: currentPage)
        
        NetworkManager.request(url: url) { result in
            completion(result)
        }
    }
}
