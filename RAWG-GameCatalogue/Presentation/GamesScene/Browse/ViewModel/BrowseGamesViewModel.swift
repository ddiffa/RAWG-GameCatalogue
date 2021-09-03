//
//  BrowseGamesViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 03/09/21.
//

import Foundation

struct BrowseGamesViewModelActions {
    let showAboutScene: (() -> Void)
}

protocol BrowseGamesViewModelInput {
    func didTapProfileMenu()
}

protocol BrowseGamesViewModel: BrowseGamesViewModelInput {}

final class DefaultBrowseGamesViewModel: BrowseGamesViewModel {
    
    private let actions: BrowseGamesViewModelActions
    
    init(actions: BrowseGamesViewModelActions) {
        self.actions = actions
    }
    
    func didTapProfileMenu() {
        actions.showAboutScene()
    }
}
