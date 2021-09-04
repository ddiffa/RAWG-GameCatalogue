//
//  DefaultGamesRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

final class DefaultGamesRepository {
    private let dataTransferService: DataTransferService
    private let coreDataFavoriteStorage: CoreDataFavoriteGamesStorage
    
    init(dataTransferService: DataTransferService,
         coreDataFavoriteStorage: CoreDataFavoriteGamesStorage) {
        self.dataTransferService = dataTransferService
        self.coreDataFavoriteStorage = coreDataFavoriteStorage
    }
}

extension DefaultGamesRepository: GamesRepository {
    
    func fetchGameList(query: GameQuery, completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable? {
        
        let requestDTO = GamesRequestDTO(ordering: query.ordering,
                                         genres:query.genres,
                                         search: query.search)
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.fetchGamesData(with: requestDTO)
        
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        return task
    }
    
    func fetchGameDetail(gameID: String, completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.fetchDetailGames(id: gameID)
        
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
        return task
    }
    
    func saveGameToFavorite(game: DetailGame,
                            completion: @escaping ((Result<Game, Error>) -> Void)) {
        coreDataFavoriteStorage.saveRecentGames(game: game,
                                                completion: completion)
    }
    
    func fetchAllFavoriteGames(completion: @escaping ((Result<[Game], Error>) -> Void)) {
        coreDataFavoriteStorage.fetchAllFavoriteGames(completion: completion)
    }
    
    func deleteFromFavorite(gameID: Int,
                            completion: @escaping ((Result<Game, Error>) -> Void)) {
        coreDataFavoriteStorage.deleteFromFavorite(gameID: gameID,
                                                   completion: completion)
    }
    
    func findFavoriteGamesById(game: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        coreDataFavoriteStorage.findByID(gameID: game,
                                         completion: completion)
    }
}
