//
//  GamesRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

protocol GamesRepository {
    @discardableResult
    func fetchGameList(query: GameQuery,
                       completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable?
}
