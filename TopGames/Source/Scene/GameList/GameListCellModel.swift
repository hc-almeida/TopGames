//
//  GamesListCellModel.swift
//  TopGames
//
//  Created by Hellen on 06/11/21.
//

import Foundation

struct GameListCellModel {
    
    var model: Games
    
    init(model: Games) {
        self.model = model
    }
    
    var id: Int {
        return model.id
    }
    
    var image: String? {
        return model.backgroundImage
    }
    
    var name: String? {
        return model.name ?? nil
    }
    
    var metacriticScore: Int? {
        return model.metacritic ?? nil
    }

    var genres: String {
        let genreName: String = model.genres
            .prefix(2)
            .map({ ($0.name) })
            .joined(separator: " - ")
        return genreName
    }
}
