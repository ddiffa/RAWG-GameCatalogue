//
//  DetailGamesUseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

protocol DetailGamesUseCase {
    func execute(gamesID: String,
                 completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancellable?
}

final class DefaultDetailGamesUseCase: DetailGamesUseCase {
    private let detailGameRepository: DetailGamesRepository
    
    init(detailGameRepository: DetailGamesRepository) {
        self.detailGameRepository = detailGameRepository
    }
    
    func execute(gamesID: String, completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancellable? {
        return detailGameRepository.fetchGameDetail(gameID: gamesID, completion: completion)
    }
}
