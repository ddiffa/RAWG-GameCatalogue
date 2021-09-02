//
//  DetailGamesRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

protocol DetailGamesRepository {
    
    @discardableResult
    func fetchGameDetail(gameID: String,
                         completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancelable?
}
