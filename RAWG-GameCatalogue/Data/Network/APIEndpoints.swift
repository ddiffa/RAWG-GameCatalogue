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
}
