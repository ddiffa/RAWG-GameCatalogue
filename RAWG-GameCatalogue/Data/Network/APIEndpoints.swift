//
//  APIEndpoints.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation


struct APIEndpoints {
    
    static func fetchGamesData(with gamesRequestDTO: GamesRequestDTO) -> Endpoint<GamesResponseDTO> {
        return Endpoint(path: "api/games",
                        method: .get,
                        queryParametersEncodable: gamesRequestDTO)
    }
    
    static func fetchGenresData() -> Endpoint<GenresResponseDTO> {
        return Endpoint(path: "api/genres",
                        method: .get)
    }
    
    static func fetchScreenShootGames(gamePK: String) -> Endpoint<String> {
        return Endpoint(path: "api/games/\(gamePK)/screenshots",
                        method: .get)
    }
    
    static func fetchDetailGames(id: String) -> Endpoint<String> {
        return Endpoint(path: "api/games/\(id)",
                        method: .get)
    }
    
    
}
