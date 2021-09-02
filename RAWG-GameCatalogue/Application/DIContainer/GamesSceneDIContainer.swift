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
    
    func makeDetailGamesUseCase() -> DetailGamesUseCase {
        return DefaultDetailGamesUseCase(detailGameRepository: makeDetailGamesRepository())
    }
    
    // MARK: - Repository
    func makeGamesRepository() -> GamesRepository {
        return DefaultGamesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeGenresRepository() -> GenresRepository {
        return DefaultGenresRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makeDetailGamesRepository() -> DetailGamesRepository {
        return DefaultDetailGamesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - ViewModel
    func makeGamesViewModel(actions: GamesViewModelAction) -> GamesViewModel {
        return DefaultGamesViewModel(searchGamesUseCase: makeSearchGamesUseCase(), actions: actions)
    }
    
    func makeSearchGamesViewModel(actions: SearchViewModelActions) -> SearchViewModel {
        return DefaultSearchViewModel(genresUseCase: makeGenresUseCase(), actions: actions)
    }
    
    func makeDetailGamesViewModel() -> DetailGamesViewModel {
        return DefaultDetailGamesViewModel(detailGamesUseCase: makeDetailGamesUseCase())
    }
    //MARK: - View controller
    func makeBrowseGamesViewController() -> UIViewController {
        let vc = BrowseGamesViewController()
        let navController = UINavigationController(rootViewController: vc)
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.gamesViewController = makeGamesViewController()
        vc.gamesViewController?.viewModel = makeGamesViewModel(actions: appFlowCoordinator.makeActionsGames())
        return navController
    }
    
    func makeSearchViewController() -> UIViewController {
        let vc = SearchViewController()
        let navController = UINavigationController(rootViewController: vc)
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.viewModel = makeSearchGamesViewModel(actions: appFlowCoordinator.makeActionsSearchGames())
        return navController
    }
    
    func makeGamesViewController() -> GamesViewController {
        let vc = GamesViewController()
        return vc
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
    func makeSeeAllGamesViewController(navController: UINavigationController,
                                       genreID: String,
                                       genre: String) -> SeeAllViewController {
        let vc = SeeAllViewController()
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.gamesViewController = makeGamesViewController()
        vc.gamesViewController?.genre = genreID
        vc.gamesViewController?.viewModel = makeGamesViewModel(actions: appFlowCoordinator.makeActionsGames())
        vc.titleString = genre
        return vc
    }
    
    func makeGamesDetailViewController(gamesID: String) -> DetailViewController {
        let vc = DetailViewController()
        vc.viewModel = makeDetailGamesViewModel()
        vc.gamesID = gamesID
        return vc
    }
    
    func makeResultSearchViewController() -> ResultSearchViewController {
        return ResultSearchViewController()
    }
}
