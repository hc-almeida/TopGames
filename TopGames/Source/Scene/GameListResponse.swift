//
//  GameListResponse.swift
//  TopGames
//
//  Created by Hellen on 06/11/21.
//

import Foundation

struct GameListResponse: Decodable {
    let games: [Games]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct Games: Decodable {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case metacritic
        case genres
    }
}

struct Genres: Decodable {
    let name: String
}
