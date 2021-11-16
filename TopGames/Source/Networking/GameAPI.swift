//
//  GameAPI.swift
//  TopGames
//
//  Created by Hellen on 06/11/21.
//

import Foundation

struct GameAPI {
    
    static let baseURL = "https://api.rawg.io/api/games"
    static let key = "9f30d73fb34543318f8d2d6aea8fb41d"
    static let pageLimit = "20"
    
    public static func build(page: Int) -> String {
        return "\(GameAPI.baseURL)?key=\(key)&page_size=\(pageLimit)&page=\(page)"
    }
    
    public static func build(detailsOf id: Int) -> String {
        return "\(GameAPI.baseURL)\(id)?key=\(key)"
    }
}
