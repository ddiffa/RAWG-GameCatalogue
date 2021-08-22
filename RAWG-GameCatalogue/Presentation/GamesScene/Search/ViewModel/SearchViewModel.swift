//
//  SearchViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

struct SearchViewModelActions {
    let showSellGames: ((SeeAllGamesType, String) -> Void)
    let showQueryGames: (() -> Void)
    let showAboutScene: (() -> Void)
    let showGameDetails: (() -> Void)
}

protocol SearchViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func didTapRightBarItem()
    func didTapSeeAll(type: SeeAllGamesType)
    func didSelectItem(at index: Int)
}

protocol SearchViewModel: SearchViewModelInput {}


final class DefaultSearchViewModel: SearchViewModel {
    
    private let searchGamesUseCase: SearchGamesUseCase
    private let actions: SearchViewModelActions?
    
    init(searchGamesUseCase: SearchGamesUseCase, actions: SearchViewModelActions) {
        self.searchGamesUseCase = searchGamesUseCase
        self.actions = actions
    }
    
    private func fetchGenres() {
        
    }
    
    private func searchGames(query: String) {
        
    }
    
    private func handle(error: Error) {
        
    }
}


extension DefaultSearchViewModel {
    func viewDidLoad() {
        fetchGenres()
    }
    
    func didLoadNextPage() {
        
    }
    
    func didSearch(query: String) {
        searchGames(query: query)
    }
    
    func didCancelSearch() {
        
    }
    
    func didTapSeeAll(type: SeeAllGamesType) {
        
    }
    
    func didTapRightBarItem() {
        actions?.showAboutScene()
    }
    
    func didSelectItem(at index: Int) {
        actions?.showSellGames(SeeAllGamesType.genres, "action")
    }

}
