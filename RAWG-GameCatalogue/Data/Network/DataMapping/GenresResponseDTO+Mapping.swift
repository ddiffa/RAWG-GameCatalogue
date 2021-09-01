//
//  GenresResponseDTO+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation


struct GenresResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case genres = "results"
    }
    
    let count: Int?
    let next: String?
    let previous: String?
    
    let genres: [GenresResponse]
}

extension GenresResponseDTO {
    
    struct GenresResponse: Decodable {
        let id: Int
        let name: String?
        var imageBackground: String?
        
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageBackground = "image_background"
        }
    }
}


extension GenresResponseDTO {
    func toDomain() -> GenresPage {
        return .init(count: count, next: next, previous: previous, genres: genres.map {
            $0.toDomain()
        })
    }
}

extension GenresResponseDTO.GenresResponse {
    func toDomain() -> Genre {
        return .init(id: id, name: name, imageBackground: imageBackground)
    }
}
