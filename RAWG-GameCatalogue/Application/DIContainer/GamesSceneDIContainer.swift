//
//  GamesSceneDIContainer.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit


final class GamesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    // MARK: - UseCase
    func makeSearchGamesUseCase() -> SearchGamesUseCase {
        return DefaultSearchGamesUseCase(gamesRepository: makeGamesRepository())
    }
    
    func makeGenresUseCase() -> GenresUseCase {
        return DefaultGenresUseCase(genresRepository: makeGenresRepository())
    }
    
    // MARK: - Repository
    func makeGamesRepository() -> GamesRepository {
        return DefaultGamesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeGenresRepository() -> GenresRepository {
        return DefaultGenresRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - ViewModel
    func makeBrowseGamesViewModel(actions: BrowseGamesViewModelActions) -> BrowseGamesViewModel {
        return DefaultBrowseGamesViewModel(searchGamesUseCase: makeSearchGamesUseCase(), actions: actions)
    }
    
    func makeSearchGamesViewModel(actions: SearchViewModelActions) -> SearchViewModel {
        return DefaultSearchViewModel(genresUseCase: makeGenresUseCase(), actions: actions)
    }
    
    //MARK: - View controller
    func makeBrowseGamesViewController() -> UIViewController {
        let vc = BrowseGamesViewController()
        let navController = UINavigationController(rootViewController: vc)
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.viewModel = makeBrowseGamesViewModel(actions: appFlowCoordinator.makeActionsBrowseGames())
        return navController
    }
    
    func makeSearchViewController() -> UIViewController {
        let vc = SearchViewController()
        let navController = UINavigationController(rootViewController: vc)
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.viewModel = makeSearchGamesViewModel(actions: appFlowCoordinator.makeActionsSearchGames())
        return navController
    }
    
    func makeMainTabBarViewController() -> MainTabBarViewController {
        let viewControllers: [UIViewController] = [makeBrowseGamesViewController(), makeSearchViewController()]
        return MainTabBarViewController.create(with: viewControllers)
    }
    
    func makeAboutViewController() -> AboutViewController {
        return AboutViewController()
    }
    
    //MARK: Flow Coordinators
    func makeGamesFlowCoordinator(navigationController: UINavigationController) -> GamesFlowCoordinator {
        return GamesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension GamesSceneDIContainer: GamesFlowCoordinatorDependencies {
    func makeSeeAllGamesViewController(type: SeeAllGamesType) -> SeeAllViewController {
        return SeeAllViewController()
    }
    
    func makeGamesDetailViewController() -> DetailViewController {
        return DetailViewController()
    }
    
    func makeResultSearchViewController() -> ResultSearchViewController {
        return ResultSearchViewController()
    }
}
