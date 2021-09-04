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
    @discardableResult
    func fetchGameDetail(gameID: String, completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancellable?
    
    func saveGameToFavorite(game: DetailGame,
                            completion: @escaping ((Result<Game, Error>) -> Void))
    
    func fetchAllFavoriteGames(completion: @escaping ((Result<[Game], Error>) -> Void))
    
    func deleteFromFavorite(gameID: Int,
                            completion: @escaping ((Result<Game, Error>) -> Void))
    
    func findFavoriteGamesById(game: Int,
                               completion: @escaping(Result<Int, Error>) -> Void)
}
