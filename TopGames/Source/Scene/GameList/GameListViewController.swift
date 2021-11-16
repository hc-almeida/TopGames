//
//  GameListViewController.swift
//  TopGames
//
//  Created by Hellen on 01/11/21.
//

import UIKit

class GameListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel = GameListViewModel()
        
    private lazy var gameListView: GameListView = {
        return GameListView()
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = gameListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel.stateChanged = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let stateDescription = self.viewModel.stateDescription ?? ""
                self.gameListView.configure(games: self.viewModel.gamesList, stateDescription: stateDescription)
            }
        }
        viewModel.loadGames()
    }
}
