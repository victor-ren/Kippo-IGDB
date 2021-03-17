//
//  GameList.swift
//  Kippo IGDB App
//
//  Created by Victor Ren on 2021-03-16.
//

import Foundation

class GameList: GameService {
    
    static let shared = GameList()
    private init() {}
    
    private let apiKey = "gu9m469ok3bzfwcb5wkpgpxim8iyl2"
    private let baseAPIURL = "Host"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchGames(from endpoint: GameListEndpoint, completion: @escaping (Result<GameResponse, GameError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/game/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func fetchGame(id: Int, completion: @escaping (Result<Game, GameError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/game/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "append_to_response": "videos, credits"
            ], completion: completion)
    }
    
    func searchGame(query: String, completion: @escaping (Result<GameResponse, GameError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/search/game") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, params: [
            "language": "en-US",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, GameError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
    
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, GameError>, completion: @escaping (Result<D, GameError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
}
