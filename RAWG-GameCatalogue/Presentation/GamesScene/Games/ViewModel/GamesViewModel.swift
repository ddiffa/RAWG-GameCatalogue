//
//  BaseGamesViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

struct GamesViewModelAction {
    let showGameDetails: ((String) -> Void)
}

protocol GamesViewModelInput {
    func fetchData(genre: String, searchQueary: String)
    func didSelectItem(navController: UINavigationController, at gamesID: String)
    func startDownloadImage(game: Game,
                            indexPath: IndexPath,
                            containerSize: CGSize,
                            completion: @escaping()-> Void)
    func toggleSuspendOperations(isSuspended: Bool)
}

protocol GamesViewModelOutput {
    var items: Observable<[Game]> { get }
    var loading: Observable<Bool> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
}

protocol GamesViewModel: GamesViewModelInput, GamesViewModelOutput {}

final class DefaultGamesViewModel: GamesViewModel {
    private let searchGamesUseCase: SearchGamesUseCase
    private let actions: GamesViewModelAction?
    private let pendingOpearions = PendingOperations()
    
    private var gamesLoadTask: Cancellable? { willSet { gamesLoadTask?.cancel() } }
    
    let items: Observable<[Game]> = Observable([])
    let loading: Observable<Bool> = Observable(false)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Movies", comment: "")
    
    init(searchGamesUseCase: SearchGamesUseCase, actions: GamesViewModelAction? = nil) {
        self.searchGamesUseCase = searchGamesUseCase
        self.actions = actions
    }
    
    private func fetch(query: GameQuery) {
        self.loading.value = true
        
        if !query.search.isEmpty {
            gamesLoadTask?.cancel()
            pendingOpearions.downloadInProgress.removeAll()
            pendingOpearions.downloadQueue.cancelAllOperations()
        }
        
        gamesLoadTask = searchGamesUseCase.execute(requestValue: .init(query: query)) { result in
            switch result {
                case .success(let data):
                    self.items.value = data.games
                case .failure(let error):
                    self.handle(error: error)
            }
            self.loading.value = false
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading games data", comment: "")
    }
    
}


extension DefaultGamesViewModel {
    
    func fetchData(genre: String, searchQueary: String) {
        fetch(query: .init(ordering: "-metacritic", genres: genre, search: searchQueary))
    }
    
    func didSelectItem(navController: UINavigationController, at gamesID: String) {
        actions?.showGameDetails(gamesID)
    }
        
    func startDownloadImage(game: Game,
                            indexPath: IndexPath,
                            containerSize: CGSize,
                            completion: @escaping () -> Void) {
        guard pendingOpearions.downloadInProgress[indexPath] == nil else { return }
        let backgroundDownloaderImage = BackgroundDownloadImage()
        backgroundDownloaderImage.downloader = ImageDownloader(game: game, containerSize: containerSize)
        backgroundDownloaderImage.startDownloadImage(indexPath: indexPath) { downloader in
            downloader.completionBlock = {
                if downloader.isCancelled  { return }
                
                DispatchQueue.main.async {
                    self.pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                    if downloader.isCancelled {
                        return
                    }
                    completion()
                }
            }
        }
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        pendingOpearions.downloadQueue.isSuspended = isSuspended
    }
}
