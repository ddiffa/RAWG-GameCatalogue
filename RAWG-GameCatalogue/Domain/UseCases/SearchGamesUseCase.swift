//
//  SearchGamesUseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

protocol SearchGamesUseCase {
    @discardableResult
    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable?
    
    func fetchAllFavoriteGames(completion:@escaping (Result<[Game], Error>) -> Void)
}

final class DefaultSearchGamesUseCase: SearchGamesUseCase {
    private let gamesRepository: GamesRepository
    
    init(gamesRepository: GamesRepository) {
        self.gamesRepository = gamesRepository
    }
    
    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable? {
        return gamesRepository.fetchGameList(query: requestValue.query,
                                             completion: completion)
    }
    
    func fetchAllFavoriteGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        return gamesRepository.fetchAllFavoriteGames(completion: completion)
    }
}

struct SearchGamesUseCaseRequestValue {
    let query: GameQuery
}
