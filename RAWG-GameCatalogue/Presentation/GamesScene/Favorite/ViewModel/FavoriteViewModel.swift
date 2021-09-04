//
//  FavoriteViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 05/09/21.
//

import Foundation

struct FavoriteViewModelActions {
    let showAboutScene: (() -> Void)
}

protocol FavoriteViewModelInput {
    func didTapProfileMenu()
}

protocol FavoriteViewModel: FavoriteViewModelInput {}

final class DefaultFavoriteViewModel: FavoriteViewModel {
    
    private let actions: FavoriteViewModelActions
    
    init(actions: FavoriteViewModelActions) {
        self.actions = actions
    }
    
    func didTapProfileMenu() {
        actions.showAboutScene()
    }
}
