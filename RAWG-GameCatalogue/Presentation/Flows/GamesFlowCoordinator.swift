//
//  GamesFlowCoordinator.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

protocol GamesFlowCoordinatorDependencies {
    func makeSeeAllGamesViewController(navController: UINavigationController,
                                       genreID: String,
                                       genre: String) -> SeeAllViewController
    
    func makeGamesDetailViewController(gamesID: String) -> DetailViewController
    
    func makeResultSearchViewController() -> ResultSearchViewController
}

final class GamesFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: GamesFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: GamesFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    private func showAboutScene() {
        let vc = AboutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func makeActionsGames() -> GamesViewModelAction {
        let actions = GamesViewModelAction(showGameDetails: showGamesDetails)
        return actions
    }
    
    func makeActionsSearchGames() -> SearchViewModelActions {
        let action = SearchViewModelActions(showSeeAllGames: showSeeAllGames,
                                            showAboutScene: showAboutScene,
                                            showGameDetails: showGamesDetails)
        return action
    }
    
    func makeActionsProfile() -> BrowseGamesViewModelActions {
        let action = BrowseGamesViewModelActions(showAboutScene: showAboutScene)
        return action
    }
    
    private func showGamesDetails(gamesID: String) {
        let vc = dependencies.makeGamesDetailViewController(gamesID: gamesID)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSeeAllGames(navController: UINavigationController,
                                 genreID: String,
                                 genres: String = "") {
        let vc = dependencies.makeSeeAllGamesViewController(navController: navController,
                                                            genreID: genreID,
                                                            genre: genres)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
