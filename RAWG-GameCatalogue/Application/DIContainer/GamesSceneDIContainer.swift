//
//  GamesSceneDIContainer.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation


final class GamesSceneDIContainer {
    
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeSearchGamesUseCase() -> SearchGamesUseCase {
        return DefaultSearchGamesUseCase(gamesRepository: makeGamesRepository())
    }
    
    func makeGamesRepository() -> GamesRepository {
        return DefaultGamesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeBrowseGamesViewController(actions: BrowseGamesViewModelActions) -> BrowseGamesViewController {
        return BrowseGamesViewController.create(with: makeBrowseGamesViewModel(actions: actions))
    }
    
    func makeBrowseGamesViewModel(actions: BrowseGamesViewModelActions) -> BrowseGamesViewModel {
        return DefaultBrowseGamesViewModel(searchGamesUseCase: makeSearchGamesUseCase(), actions: actions)
    }
}
