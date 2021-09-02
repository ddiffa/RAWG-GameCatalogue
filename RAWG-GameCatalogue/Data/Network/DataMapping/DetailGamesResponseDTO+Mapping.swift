//
//  DetailGamesResponseDTO+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation


struct DetailGamesResponseDTO {
    let id: Int64
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    let website: String
    let rating: Double
    let playTime: Int
    
    
    let parentPlatform: [Platform]
    let genres: [Genres]
}

extension DetailGamesResponseDTO {
    
    struct Platform {
        let id: Int64
        let name: String
    }
    
    struct Developers {
        let id: Int64
        let name: String
    }
    
    struct Genres {
        let id: Int64
        let name: String
    }
}
