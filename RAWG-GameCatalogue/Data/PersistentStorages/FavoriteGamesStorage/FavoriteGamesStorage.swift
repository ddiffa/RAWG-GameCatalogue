//
//  FavoriteGamesStorage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation

protocol FavoriteGamesStorage {
    func fetchAllFavoriteGames(completion: @escaping(Result<[Game], Error>) -> Void)
    func saveRecentGames(game: DetailGame,
                         completion: @escaping(Result<Game, Error>) -> Void)
    func deleteFromFavorite(game: FavoriteGames,
                            completion: @escaping(Result<[Game], Error>) -> Void)
}
