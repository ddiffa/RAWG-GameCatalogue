//
//  BrowseGamesViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit

struct BrowseGamesViewModelActions {
    let showGameDetails: (() -> Void)
    let showSeeAllGames: ((SeeAllGamesType, String) -> Void)
    let showAboutScene: (() -> Void)
}

enum BrowseGamesViewModelLoading {
    case fullScreen
    case nextPage
}

protocol BrowseGameViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didTapRightBarItem()
    func didTapSeeAll(type: SeeAllGamesType)
    func didSelectItem(at index: Int)
}

//protocol BrowseGameViewModelOutput {
//    var items: Observable<[]>
//}


protocol BrowseGamesViewModel: BrowseGameViewModelInput {}

final class DefaultBrowseGamesViewModel: BrowseGamesViewModel {
    private let searchGamesUseCase: SearchGamesUseCase
    private let actions: BrowseGamesViewModelActions?
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private var pages: [GamesResponseDTO] = []
    private var gamesLoadTask: Cancelable? { willSet { gamesLoadTask?.cancel() } }
    
    let loading: Observable<BrowseGamesViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return false }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Movies", comment: "")
    
    init(searchGamesUseCase: SearchGamesUseCase, actions: BrowseGamesViewModelActions? = nil) {
        self.searchGamesUseCase = searchGamesUseCase
        self.actions = actions
    }
    
    
    private func fetch(query: GameQuery, loading: BrowseGamesViewModelLoading) {
        self.loading.value = loading
        self.query.value = query.query
        
        gamesLoadTask = searchGamesUseCase.execute(requestValue: .init(query: query, page: nextPage)) { result in
            
            switch result {
                case .success(let data):
                    print(data.games)
                case .failure(let error):
                    print(error)
            }
            self.loading.value = .none
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? NSLocalizedString("No internet connection", comment: "") :
         NSLocalizedString("Failed loading games data", comment: "")
    }
    
}


extension DefaultBrowseGamesViewModel {
    func viewDidLoad() {
        fetch(query: .init(query: query.value), loading: .nextPage)
    }
    
    func didLoadNextPage() {
        
    }
        
    func didSelectItem(at index: Int) {
        print("Show Game Details")
        actions?.showGameDetails()
    }
    
    func didTapRightBarItem() {
        actions?.showAboutScene()
    }
    
    func didTapSeeAll(type: SeeAllGamesType) {
        print("didTap")
        actions?.showSeeAllGames(type, "")
    }
}
