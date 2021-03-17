//
//  Game+Stub.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import Foundation

extension Game {
    static var stubbedGames: [Game] {
        let response: GameResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "game_list")
        return response!.results
    }
    
    static var stubbedGame: Game {
        stubbedGames[0]
    }
}


extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
