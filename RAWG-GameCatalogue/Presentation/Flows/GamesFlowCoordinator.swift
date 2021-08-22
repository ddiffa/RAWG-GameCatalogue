//
//  GamesFlowCoordinator.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

protocol GamesFlowCoordinatorDependencies {
    func makeSeeAllGamesViewController(type: SeeAllGamesType) -> SeeAllViewController
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
    
    func makeActionsBrowseGames() -> BrowseGamesViewModelActions {
        let actions = BrowseGamesViewModelActions(showGameDetails: showGamesDetails, showSeeAllGames: showSeeAllGames, showAboutScene: showAboutScene)
        
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
    
    private func showSeeAllGames(type: SeeAllGamesType, genres: String = "") {
        let vc = dependencies.makeSeeAllGamesViewController(type: type)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
