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
    
    func makeProfileUseCase() -> ProfileUseCase {
        return DefaultProfileUseCase(profileRepository: makeProfileRepository())
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
    
    func makeProfileRepository() -> ProfileRepository {
        return DefaultProfileRepository(userDefaultsProfileStorage: makeProfileUserDefaults())
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
    
    func makeBrowseGamesViewModel(actions: BrowseGamesViewModelActions) -> BrowseGamesViewModel {
        return DefaultBrowseGamesViewModel(actions: actions)
    }
    
    func makeProfileViewModel() -> AboutProfileViewModel {
        return DefaultAboutProfileViewModel(profileUseCase: makeProfileUseCase())
    }
    // MARK: - View Controller
    func makeBrowseGamesViewController() -> UIViewController {
        let vc = BrowseGamesViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.gamesViewController = makeGamesViewController()
        vc.gamesViewController?.viewModel = makeGamesViewModel(actions: appFlowCoordinator.makeActionsGames())
        vc.viewModel = makeBrowseGamesViewModel(actions: appFlowCoordinator.makeActionsProfile())
        return navController
    }
    
    func makeSearchViewController() -> UIViewController {
        let vc = SearchViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.prefersLargeTitles = true
        let appFlowCoordinator = makeGamesFlowCoordinator(navigationController: navController)
        vc.viewModel = makeSearchGamesViewModel(actions: appFlowCoordinator.makeActionsSearchGames())
        vc.resultSearchVC = makeResultSearchVC(gamesActions: appFlowCoordinator
                                                .makeActionsGames(),
                                               rootNavController: navController)
        return navController
    }
    
    func makeResultSearchVC(gamesActions: GamesViewModelAction, rootNavController: UINavigationController) -> ResultSearchViewController {
        let vc = ResultSearchViewController()
        vc.rootNavigationController = rootNavController
        vc.gamesViewController = makeGamesViewController()
        vc.gamesViewController?.viewModel = makeGamesViewModel(actions: gamesActions)
        vc.gamesViewController?.isSearchGames  = true
        return vc
    }
    
    func makeGamesViewController() -> GamesViewController {
        let vc = GamesViewController()
        return vc
    }
    
    func makeMainTabBarViewController() -> MainTabBarViewController {
        let viewControllers: [UIViewController] = [makeBrowseGamesViewController(), makeSearchViewController()]
        return MainTabBarViewController.create(with: viewControllers)
    }
    
    // MARK: - Flow Coordinators
    func makeGamesFlowCoordinator(navigationController: UINavigationController) -> GamesFlowCoordinator {
        return GamesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - Persistent
    func makeProfileUserDefaults() -> UserDefaultsProfileStorage {
        return UserDefaultsProfileStorage()
    }
    
    func makeCoreDataStorage() -> CoreDataFavoriteGamesStorage {
        return CoreDataFavoriteGamesStorage()
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
    
    func makeAboutProfileViewController() -> AboutViewController {
        let vc = AboutViewController()
        vc.viewModel = makeProfileViewModel()
        return vc
    }
}
