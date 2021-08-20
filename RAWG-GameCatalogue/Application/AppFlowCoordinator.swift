//
//  AppFlowCoordinator.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start(){
        let _ = appDIContainer.makeGamesSceneDIContainer()
        
//        let actions = BrowseGamesViewModelActions(showGameDetails: {})
//
//        let vc = dependencies.makeMoviesListViewController(actions: actions)
//        
//        navigationController?.pushViewController(vc, animated: false)
//        moviesListVC = vc
    }
}
