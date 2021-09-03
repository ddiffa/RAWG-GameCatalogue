//
//  DetailGamesResponseDTO+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

struct DetailGamesResponseDTO: Decodable {
    let id: Int64?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let playTime: Int?
    let reviewCount: Int?
    
    let parentPlatform: [ParentPlatforms]?
    let genres: [Genres]?
    let developers: [Developers]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case released
        case backgroundImage = "background_image"
        case rating
        case playTime = "playtime"
        case parentPlatform = "parent_platforms"
        case genres
        case developers
        case reviewCount = "reviews_count"
    }
}

extension DetailGamesResponseDTO {
    
    struct ParentPlatforms: Decodable {
        let platform: Platform?
        
        private enum CodingKeys: String, CodingKey {
            case platform
        }
    }
    
    struct Platform: Decodable {
        let name: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    struct Developers: Decodable {
        let name: String
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    struct Genres: Decodable {
        let name: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
}

extension DetailGamesResponseDTO {
    
    func toDomain() -> DetailGame {
        return .init(id: id,
                     name: name,
                     description: description,
                     released: released,
                     backgroundImage: backgroundImage,
                     rating: rating,
                     playTime: playTime,
                     parentPlatform: convertArrayPlatformToString(platform: parentPlatform),
                     genres: convertArrayGenreToString(genre: genres),
                     developers: developers?.first?.name,
                     reviewCount: reviewCount)
    }
    
    func convertArrayPlatformToString(platform: [DetailGamesResponseDTO.ParentPlatforms]?) -> String {
        var platformName: [String] = []
        
        platform?.forEach { data in
            
            if let name = data.platform?.name {
                platformName.append(name)
            }
        }
        
        return platformName.joined(separator: ", ")
    }
    
    func convertArrayGenreToString(genre: [DetailGamesResponseDTO.Genres]?) -> String {
        var genreName: [String] = []
        
        genres?.forEach { data in
            
            if let name = data.name {
                genreName.append(name)
            }
        }
        
        return genreName.joined(separator: ", ")
    }
}
