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
    case show
}

protocol BrowseGameViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didTapRightBarItem()
    func didTapSeeAll(type: SeeAllGamesType)
    func didSelectItem(at index: Int)
    func startDownloadImage(game: Game, indexPath: IndexPath, completion: @escaping()-> Void)
    func toggleSuspendOperations(isSuspended: Bool)
}

protocol BrowseGameViewModelOutput {
    var items: Observable<[Game]> { get }
    var loading: Observable<BrowseGamesViewModelLoading?> { get }
    var query: Observable<String> { get }
    var isEmpty: Bool { get }
    var error: Observable<String> { get }
}


protocol BrowseGamesViewModel: BrowseGameViewModelInput, BrowseGameViewModelOutput {}

final class DefaultBrowseGamesViewModel: BrowseGamesViewModel {
    private let searchGamesUseCase: SearchGamesUseCase
    private let actions: BrowseGamesViewModelActions?
    
    
    let _pendingOpearions = PendingOperations()
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private var pages: [GamesPage] = []
    private var gamesLoadTask: Cancelable? { willSet { gamesLoadTask?.cancel() } }
    
    let items: Observable<[Game]> = Observable([])
    let loading: Observable<BrowseGamesViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return false }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    init(searchGamesUseCase: SearchGamesUseCase, actions: BrowseGamesViewModelActions? = nil) {
        self.searchGamesUseCase = searchGamesUseCase
        self.actions = actions
    }
    
    private func appendPage(_ gamesPage: GamesPage) {
        items.value = gamesPage.games
    }
    
    
    private func fetch(query: GameQuery) {
        self.loading.value = .show
        self.query.value = query.query
        
        gamesLoadTask = searchGamesUseCase.execute(requestValue: .init(query: query, page: nextPage)) { result in
            
            switch result {
                case .success(let data):
                    self.appendPage(data)
                case .failure(let error):
                    self.handle(error: error)
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
        fetch(query: .init(query: query.value))
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
    
    func startDownloadImage(game: Game, indexPath: IndexPath, completion: @escaping () -> Void) {
        guard _pendingOpearions.downloadInProgress[indexPath] == nil else { return }
        
        let downloader = ImageDownloader(game: game)
        
        downloader.completionBlock = {
            if downloader.isCancelled  { return }
            
            DispatchQueue.main.async {
                self._pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                completion()
            }
        }
        
        _pendingOpearions.downloadInProgress[indexPath] = downloader
        _pendingOpearions.downloadQueue.addOperation(downloader)
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        _pendingOpearions.downloadQueue.isSuspended = isSuspended
    }
}
