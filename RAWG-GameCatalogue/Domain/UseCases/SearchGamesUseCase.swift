//
//  SearchGamesUseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

protocol SearchGamesUseCase {
    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 completion: @escaping (Result<GamesResponseDTO, Error>) -> Void) -> Cancelable?
}


final class DefaultSearchGamesUseCase: SearchGamesUseCase {
    private let gamesRepository: GamesRepository
    
    init(gamesRepository: GamesRepository) {
        self.gamesRepository = gamesRepository
    }
    
    func execute(requestValue: SearchGamesUseCaseRequestValue, completion: @escaping (Result<GamesResponseDTO, Error>) -> Void) -> Cancelable? {
        return gamesRepository.fetchGameList(query: requestValue.query, page: requestValue.page){ result in
            completion(result)
        }
    }
}

struct SearchGamesUseCaseRequestValue {
    let query: GameQuery
    let page: Int
}
