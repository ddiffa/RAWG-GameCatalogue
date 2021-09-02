//
//  GenresUseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

protocol GenresUseCase {
    func execute(completion: @escaping (Result<GenresPage, Error>) -> Void) -> Cancelable?
}

final class DefaultGenresUseCase: GenresUseCase {
    private let genresRepository: GenresRepository
    
    init(genresRepository: GenresRepository) {
        self.genresRepository = genresRepository
    }
    
    func execute(completion: @escaping (Result<GenresPage, Error>) -> Void) -> Cancelable? {
        return genresRepository.fetchGenres(completion: completion)
    }
}

