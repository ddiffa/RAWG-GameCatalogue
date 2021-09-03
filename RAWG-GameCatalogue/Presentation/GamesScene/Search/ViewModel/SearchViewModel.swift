//
//  SearchViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

struct SearchViewModelActions {
    let showSeeAllGames: ((UINavigationController, String, String) -> Void)
    let showAboutScene: (() -> Void)
    let showGameDetails: ((String) -> Void)
}

protocol SearchViewModelInput {
    func viewDidLoad()
    func didTapRightBarItem()
    func didSelectItem(navController: UINavigationController, genreID: String, genre: String)
    func startDownloadImage(genre: Genre, indexPath: IndexPath, containerSize: CGSize, completion: @escaping()-> Void)
    func toggleSuspendOperations(isSuspended: Bool)
}

protocol SearchViewModelOutput {
    var items: Observable<[Genre]> { get }
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
}

protocol SearchViewModel: SearchViewModelInput, SearchViewModelOutput {}


final class DefaultSearchViewModel: SearchViewModel {
    let pendingOpearions = PendingOperations()
    
    private let genresUseCase: GenresUseCase
    private let actions: SearchViewModelActions?
    
    private var genresLoadTask: Cancellable? { willSet { genresLoadTask?.cancel() } }
    
    let items: Observable<[Genre]> = Observable([])
    let error: Observable<String> = Observable("")
    let loading: Observable<Bool> = Observable(true)

    init(genresUseCase: GenresUseCase, actions: SearchViewModelActions) {
        self.genresUseCase = genresUseCase
        self.actions = actions
    }
    
    private func fetchGenres() {
        self.loading.value = true
        genresLoadTask = genresUseCase.execute { result in
            switch result {
                case .success(let data):
                    self.items.value = data.genres
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


extension DefaultSearchViewModel {
    func viewDidLoad() {
        fetchGenres()
    }
    
    func didTapRightBarItem() {
        actions?.showAboutScene()
    }
    
    func didSelectItem(navController: UINavigationController, genreID: String, genre: String) {
        actions?.showSeeAllGames(navController, genreID, genre)
    }
    
    func startDownloadImage(genre: Genre, indexPath: IndexPath, containerSize: CGSize, completion: @escaping () -> Void) {
        guard pendingOpearions.downloadInProgress[indexPath] == nil else { return }
        
        let downloader = ImageDownloader(genre: genre, containerSize: containerSize)
        
        downloader.completionBlock = {
            if downloader.isCancelled  { return }
            
            DispatchQueue.main.async {
                self.pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                completion()
            }
        }
        
        pendingOpearions.downloadInProgress[indexPath] = downloader
        pendingOpearions.downloadQueue.addOperation(downloader)
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        pendingOpearions.downloadQueue.isSuspended = isSuspended
    }

}
