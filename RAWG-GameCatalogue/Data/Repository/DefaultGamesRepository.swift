//
//  DefaultGamesRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation


final class DefaultGamesRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultGamesRepository: GamesRepository {
    
    func fetchGameList(query: GameQuery, page: Int, completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancelable? {
        
        let requestDTO = GamesRequestDTO(page: 1, ordering: query.query)
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
}
