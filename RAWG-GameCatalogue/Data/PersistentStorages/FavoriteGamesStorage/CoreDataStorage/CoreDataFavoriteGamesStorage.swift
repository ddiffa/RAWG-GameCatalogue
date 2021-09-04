//
//  CoreDataFavoriteGamesStorage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import Foundation
import CoreData

final class CoreDataFavoriteGamesStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension CoreDataFavoriteGamesStorage: FavoriteGamesStorage {
    
    func fetchAllFavoriteGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = FavoriteGames.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteGames.createdAt),
                                                            ascending: false)]
                let result = try context.fetch(request).map { $0.toDomain() }
                
                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveRecentGames(game: DetailGame,
                         completion: @escaping (Result<Game, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let entity = FavoriteGames(game: game, insertInto: context)
                try context.save()
                completion(.success(entity.toDomain()))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }
    
    func deleteFromFavorite(gameID: Int,
                            completion: @escaping (Result<Game, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = FavoriteGames.fetchRequest()
                request.predicate = NSPredicate(format: "(id = %@)", "\(gameID)")
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteGames.createdAt),
                                                            ascending: false)]
                let result = try context.fetch(request).first
                
                if let result = result {
                    context.delete(result)
                    try context.save()
                    completion(.success(result.toDomain()))
                } else {
                    completion(.failure(CoreDataStorageError.deleteError(NSError())))
                }
            } catch {
                completion(.failure(CoreDataStorageError.deleteError(error)))
            }
        }
    }
    
    func findByID(gameID: Int,
                  completion: @escaping (Result<Int, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = FavoriteGames.fetchRequest()
                request.predicate = NSPredicate(format: "(id = %@)", "\(gameID)")
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(FavoriteGames.createdAt),
                                                            ascending: false)]
                let result = try context.count(for: request)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
