//
//  GamesResponseDTO+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation


struct GamesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case games = "results"
    }
    
    let count: Int?
    let next: String?
    let previous: String?
    
    let games: [GameResponse]
}


extension GamesResponseDTO {
    
    struct GameResponse: Decodable {
        let id: Int
        let name: String?
        var imagePath: String?
        var released: String?
        var rating: Double?
        var description: String?
        let genres: [Genres]?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case imagePath = "background_image"
            case released
            case rating
            case genres
            case description
        }
    }
    
    struct Genres: Decodable {
        let name: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
}

extension GamesResponseDTO {
    func toDomain() -> GamesPage {
        return .init(count: count, next: next, previous: previous, games: games.map {
            $0.toDomain()
        })
    }
}

extension GamesResponseDTO.GameResponse {
    func toDomain() -> Game {
        return .init(id: id, name: name, imagePath: imagePath, released: released, rating: rating, description: description, genres: convertArrayGenreToString(genre: genres))
    }
    
    func convertArrayGenreToString(genre: [GamesResponseDTO.Genres]?)  -> String {
        var genreName: [String] = []
        
        genres?.forEach { data in
            
            if let name = data.name {
                genreName.append(name)
            }
        }
        
        return genreName.joined(separator: ", ")
    }
}


