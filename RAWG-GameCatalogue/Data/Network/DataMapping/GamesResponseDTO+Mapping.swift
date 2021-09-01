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
        
        let developers: [Developers]?
        let genres: [Genres]?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case imagePath = "background_image"
            case released
            case rating
            case genres
//            case parentPlatforms = "parent_platforms"
            case description
            case developers
            
        }
        
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            id = try container.decode(Int.self, forKey: .id)
//            name = try container.decode(String.self, forKey: .name)
//            imagePath = try container.decode(String?.self, forKey: .imagePath)
//            released = try container.decode(String?.self, forKey: .released)
//            rating = try container.decode(Double?.self, forKey: .rating)
//            description = try container.decode(String?.self, forKey: .description)
//
//        }
    }
    
    struct Genres: Decodable {
        let name: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    struct Developers: Decodable {
        let name: String?
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()


extension GamesResponseDTO {
    func toDomain() -> GamesPage {
        return .init(count: count, next: next, previous: previous, games: games.map {
            $0.toDomain()
        })
    }
}

extension GamesResponseDTO.GameResponse {
    func toDomain() -> Game {
        return .init(id: id, name: name, imagePath: imagePath, released: released, rating: rating, description: description)
    }
}
