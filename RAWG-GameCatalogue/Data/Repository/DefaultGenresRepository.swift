//
//  DefaultGenresRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation


final class DefaultGenresRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultGenresRepository: GenresRepository {
    
    func fetchGenres(completion: @escaping (Result<GenresPage, Error>) -> Void) -> Cancelable? {
        
        let task = RepositoryTask()
        let endpoint = APIEndpoints.fetchGenresData()
        
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
//
//    func fetchGameList(query: GameQuery, page: Int, completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancelable? {
//
//        let requestDTO = GamesRequestDTO(page: 1, ordering: query.query)
//        let task = RepositoryTask()
//
//
//        let endpoint = APIEndpoints.fetchGamesData(with: requestDTO)
//
//        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//            switch result {
//                case .success(let responseDTO):
//                    completion(.success(responseDTO.toDomain()))
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
//        return task
//    }
}
