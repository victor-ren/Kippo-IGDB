//
//  GameSerivce.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import Foundation

protocol GameService {
    
    func fetchGames(from endpoint: GameListEndpoint, completion: @escaping (Result<GameResponse, GameError>) -> ())
    func fetchGame(id: Int, completion: @escaping (Result<Game, GameError>) -> ())
    func searchGame(query: String, completion: @escaping (Result<GameResponse, GameError>) -> ())
}

enum GameListEndpoint: String {
    case trending = "trending"
    
    var description: String {
        switch self {
        case .trending: return "trending"
        }
    }
}

enum GameError: Error {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case . noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
