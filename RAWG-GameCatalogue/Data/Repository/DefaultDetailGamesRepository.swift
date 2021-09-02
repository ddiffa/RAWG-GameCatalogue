//
//  DefaultDetailGamesRepository.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

final class DefaultDetailGamesRepository {
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultDetailGamesRepository: DetailGamesRepository {
    
    func fetchGameDetail(gameID: String, completion: @escaping (Result<DetailGame, Error>) -> Void) -> Cancelable? {
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
}
