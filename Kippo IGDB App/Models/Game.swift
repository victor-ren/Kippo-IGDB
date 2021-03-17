//
//  Game.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import Foundation

struct GameResponse: Decodable {
    
    let results: [Game]
}

struct Game: Decodable {
    
    let id: Int
    let name: String
    
    var backdropURL: URL {
        return URL(string: "https://api.igdb.com/v4/games\(backdropPath ?? "")")!
    }
}
