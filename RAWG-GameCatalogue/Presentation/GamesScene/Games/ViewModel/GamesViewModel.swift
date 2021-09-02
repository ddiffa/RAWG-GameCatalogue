//
//  BaseGamesViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

struct GamesViewModelAction {
    let showGameDetails: ((String) -> Void)
    let showAboutScene: (() -> Void)
}

protocol GamesViewModelInput {
    func viewDidLoad(genre: String, searchQueary: String)
    func didTapRightBarItem()
    func didSelectItem(navController: UINavigationController, at gamesID: String)
    func startDownloadImage(game: Game, indexPath: IndexPath, completion: @escaping()-> Void)
    func toggleSuspendOperations(isSuspended: Bool)
}

protocol GamesViewModelOutput {
    var items: Observable<[Game]> { get }
    var loading: Observable<Bool> { get }
    var query: Observable<String> { get }
    var isEmpty: Bool { get }
    var error: Observable<String> { get }
}

protocol GamesViewModel: GamesViewModelInput, GamesViewModelOutput {}

final class DefaultGamesViewModel: GamesViewModel {
    private let searchGamesUseCase: SearchGamesUseCase
    private let actions: GamesViewModelAction?
    private let backgroundDownloaderImage: BackgroundDownloadImage = BackgroundDownloadImage()
    private let _pendingOpearions = PendingOperations()
    
    private var gamesLoadTask: Cancelable? { willSet { gamesLoadTask?.cancel() } }
    
    let items: Observable<[Game]> = Observable([])
    let loading: Observable<Bool> = Observable(true)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return false }
    let screenTitle = NSLocalizedString("Movies", comment: "")
    
    init(searchGamesUseCase: SearchGamesUseCase, actions: GamesViewModelAction? = nil) {
        self.searchGamesUseCase = searchGamesUseCase
        self.actions = actions
    }
    
    private func appendPage(_ gamesPage: GamesPage) {
        items.value = gamesPage.games
    }
    
    
    private func fetch(query: GameQuery) {
        self.loading.value = true
        gamesLoadTask = searchGamesUseCase.execute(requestValue: .init(query: query, page: 1)) { result in
            switch result {
                case .success(let data):
                    self.appendPage(data)
                case .failure(let error):
                    self.handle(error: error)
            }
            self.loading.value = false
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading games data", comment: "")
    }
    
}


extension DefaultGamesViewModel {
    
    func viewDidLoad(genre: String, searchQueary: String) {
        fetch(query: .init(ordering: "-metacritic", genres: genre, search: searchQueary))
    }
    
    func didSelectItem(navController: UINavigationController, at gamesID: String) {
        actions?.showGameDetails(gamesID)
    }
    
    func didTapRightBarItem() {
        actions?.showAboutScene()
    }
        
    func startDownloadImage(game: Game, indexPath: IndexPath, completion: @escaping () -> Void) {
        guard _pendingOpearions.downloadInProgress[indexPath] == nil else { return }
        
        backgroundDownloaderImage.downloader = ImageDownloader(game: game)
        backgroundDownloaderImage.startDownloadImage(indexPath: indexPath) { downloader in
            downloader.completionBlock = {
                if downloader.isCancelled  { return }
                
                DispatchQueue.main.async {
                    self._pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                    completion()
                }
            }
        }
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        _pendingOpearions.downloadQueue.isSuspended = isSuspended
    }
}
