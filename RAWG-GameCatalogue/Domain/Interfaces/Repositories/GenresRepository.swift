//
//  GenresReposiroty.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

protocol GenresRepository {
    @discardableResult
    func fetchGenres(completion: @escaping (Result<GenresPage, Error>) -> Void) -> Cancellable?
}
