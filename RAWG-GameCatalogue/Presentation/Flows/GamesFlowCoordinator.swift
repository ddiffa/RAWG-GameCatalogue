//
//  GamesFlowCoordinator.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

protocol GamesFlowCoordinatorDependencies {
    func makeSeeAllGamesViewController(navController: UINavigationController, genre: String) -> SeeAllViewController
    func makeGamesDetailViewController() -> DetailViewController
    func makeResultSearchViewController() -> ResultSearchViewController
}

final class GamesFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: GamesFlowCoordinatorDependencies
    
    
    init(navigationController: UINavigationController, dependencies: GamesFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    private func showAboutScene() {
        let vc = AboutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func makeActionsGames() -> GamesViewModelAction {
        let actions = GamesViewModelAction(showGameDetails: showGamesDetails, showAboutScene: showAboutScene)
        
        return actions
    }
    
    func makeActionsSearchGames() -> SearchViewModelActions {
        let action = SearchViewModelActions(showSellGames: showSeeAllGames, showQueryGames: {}, showAboutScene: showAboutScene, showGameDetails: showGamesDetails)
        
        return action
    }
    
    private func showGamesDetails() {
        let vc = dependencies.makeGamesDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSeeAllGames(navController: UINavigationController, genres: String = "") {
        let vc = dependencies.makeSeeAllGamesViewController(navController: navController, genre: genres)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
