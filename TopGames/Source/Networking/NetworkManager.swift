//
//  NetworkManager.swift
//  TopGames
//
//  Created by Hellen on 02/11/21.
//

import Foundation

typealias NetworkResult<T: Decodable> = ((Result<T, Error>) -> Void)

protocol NetworkManagerProtocol {
    
    static func request<T: Decodable>(url: String, completion: @escaping NetworkResult<T>)
}

class NetworkManager: NetworkManagerProtocol {
    
    static func request<T>(url: String, completion: @escaping NetworkResult<T>) {
        guard let url = URL(string: url) else { return }
        
        let dataTaks = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(APIError.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(APIError.decodeError))
            }
        }
        
        dataTaks.resume()
    }
}
