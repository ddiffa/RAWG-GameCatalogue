//
//  GamesRequestDTO+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

struct GamesRequestDTO: Encodable {
    let page: Int
    let ordering: String
    let genres: String
    let search: String
}
