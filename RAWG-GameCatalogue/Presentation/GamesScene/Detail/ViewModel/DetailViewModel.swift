//
//  DetailViewModel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

protocol DetailGamesViewModelInput {
    func viewDidLoad(gamesID: String)
    func startDownloadImage(delegate: DetailGameDelegate,
                            containerSize: CGSize)
    func toggleSuspendOperations(isSuspended: Bool)
}

protocol DetailGamesViewModelOutput {
    var items: Observable<DetailGame?> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }
}

protocol DetailGamesViewModel: DetailGamesViewModelInput, DetailGamesViewModelOutput {}

final class DefaultDetailGamesViewModel: DetailGamesViewModel {
    private let detailGamesUseCase: DetailGamesUseCase
    
    private let _backgroundDownloaderImage: BackgroundDownloadImage = BackgroundDownloadImage()
    private let _pendingOpearions = PendingOperations()
    
    let items: Observable<DetailGame?> = Observable(nil)
    let loading: Observable<Bool> = Observable(true)
    let error: Observable<String> = Observable("")
    
    
    private var gamesLoadTask: Cancelable? { willSet { gamesLoadTask?.cancel() } }
    
    init(detailGamesUseCase: DetailGamesUseCase) {
        self.detailGamesUseCase = detailGamesUseCase
    }
    
    private func fetch(gamesID: String) {
        self.loading.value = true
        
        gamesLoadTask = detailGamesUseCase.execute(gamesID: gamesID) { result in
            switch result {
                case .success(let data):
                    self.items.value = data
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

extension DefaultDetailGamesViewModel {
    
    func viewDidLoad(gamesID: String) {
        self.fetch(gamesID: gamesID)
    }
    
    func didSelectWeb(webLink: String) {
        
    }
    
    func startDownloadImage(delegate: DetailGameDelegate, containerSize: CGSize) {
        let indexPath = IndexPath.init(index: 0)
        guard _pendingOpearions.downloadInProgress[indexPath] == nil,
              let data = items.value else { return }
        
        _backgroundDownloaderImage.downloader = ImageDownloader(detailGame: data,
                                                                delegate: delegate,
                                                                containerSize: containerSize)
        _backgroundDownloaderImage.startDownloadImage(indexPath: indexPath) { downloader in
            downloader.completionBlock = {
                if downloader.isCancelled  { return }
                
                DispatchQueue.main.async {
                    self._pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                }
            }
        }
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        _pendingOpearions.downloadQueue.isSuspended = isSuspended
    }

}
