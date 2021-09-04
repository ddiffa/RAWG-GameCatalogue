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
    
    func findFavoriteGamesById(gameID: Int,
                               completion: @escaping (Result<Int, Error>) -> Void)
    
    func saveToFavoriteGames(detailGame: DetailGame,
                             completion: @escaping (Result<Game, Error>) -> Void)
    
    func deleteFromFavoriteGames(gameID: Int,
                                 completion: @escaping(Result<Game, Error>) -> Void)
}

final class DefaultDetailGamesUseCase: DetailGamesUseCase {
    
    private let gamesRepository: GamesRepository
    
    init(gamesRepository: GamesRepository) {
        self.gamesRepository = gamesRepository
    }
    
    func execute(gamesID: String, completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancellable? {
        return gamesRepository.fetchGameDetail(gameID: gamesID,
                                               completion: completion)
    }
    
    func findFavoriteGamesById(gameID: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        gamesRepository.findFavoriteGamesById(game: gameID,
                                              completion: completion)
    }
    
    func saveToFavoriteGames(detailGame: DetailGame, completion: @escaping (Result<Game, Error>) -> Void) {
        gamesRepository.saveGameToFavorite(game: detailGame,
                                           completion: completion)
    }
    
    func deleteFromFavoriteGames(gameID: Int,
                                 completion: @escaping (Result<Game, Error>) -> Void) {
        gamesRepository.deleteFromFavorite(gameID: gameID,
                                           completion: completion)
    }
}
