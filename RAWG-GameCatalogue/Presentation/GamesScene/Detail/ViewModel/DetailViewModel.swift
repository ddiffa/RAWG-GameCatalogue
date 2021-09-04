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
    func toggleFavoriteButton()
}

protocol DetailGamesViewModelOutput {
    var items: Observable<DetailGame?> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }
    var isFavorite: Observable<Bool> { get }
    var message: Observable<String> { get }
}

protocol DetailGamesViewModel: DetailGamesViewModelInput, DetailGamesViewModelOutput {}

final class DefaultDetailGamesViewModel: DetailGamesViewModel {
    private let detailGamesUseCase: DetailGamesUseCase
    
    private let backgroundDownloaderImage: BackgroundDownloadImage = BackgroundDownloadImage()
    private let pendingOpearions = PendingOperations()
    
    let items: Observable<DetailGame?> = Observable(nil)
    let loading: Observable<Bool> = Observable(false)
    let error: Observable<String> = Observable("")
    let isFavorite: Observable<Bool> = Observable(false)
    let message: Observable<String> = Observable("")
    
    private var gamesLoadTask: Cancellable? { willSet { gamesLoadTask?.cancel() } }
    
    init(detailGamesUseCase: DetailGamesUseCase) {
        self.detailGamesUseCase = detailGamesUseCase
    }
    
    private func fetch(gamesID: String) {
        self.loading.value = true
        
        gamesLoadTask = detailGamesUseCase.execute(gamesID: gamesID) { result in
            switch result {
                case .success(let data):
                    self.items.value = data
                    self.findById(gamesID: Int(gamesID) ?? 0)
                case .failure(let error):
                    self.handle(error: error)
            }
            self.loading.value = false
        }
    }
    
    private func saveFavorite() {
        if let game = items.value {
            detailGamesUseCase.saveToFavoriteGames(detailGame: game) { result in
                switch result {
                    case .success(_):
                        self.isFavorite.value.toggle()
                        self.message.value = "Success added data to favorite"
                    case .failure(_):
                        self.error.value = "Can't save data to favorite"
                }
            }
        }
    }
    
    private func deleteFromFavorite() {
        if let game = items.value,
           let id = game.id {
            detailGamesUseCase.deleteFromFavoriteGames(gameID: Int(id)) { result in
                switch result {
                    case .success(_):
                        self.isFavorite.value.toggle()
                        self.message.value = "Success deleted data from favorite"
                    case .failure(_):
                        self.error.value = "Can't delete data from favorite"
                }
            }
        }
    }
    
    private func findById(gamesID: Int) {
        detailGamesUseCase.findFavoriteGamesById(gameID: gamesID) { result in
            switch result {
                case .success(let data):
                    if data > 0 {
                        self.isFavorite.value = true
                    } else {
                        self.isFavorite.value = false
                    }
                case .failure(let error):
                    self.error.value = error.localizedDescription
            }
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.getErrorMessage()
    }
}

extension DefaultDetailGamesViewModel {
    
    func viewDidLoad(gamesID: String) {
        self.fetch(gamesID: gamesID)
    }
    
    func startDownloadImage(delegate: DetailGameDelegate, containerSize: CGSize) {
        let indexPath = IndexPath.init(index: 0)
        guard pendingOpearions.downloadInProgress[indexPath] == nil,
              let data = items.value else { return }
        
        backgroundDownloaderImage.downloader = ImageDownloader(detailGame: data,
                                                                delegate: delegate,
                                                                containerSize: containerSize)
        backgroundDownloaderImage.startDownloadImage(indexPath: indexPath) { downloader in
            downloader.completionBlock = {
                if downloader.isCancelled { return }
                DispatchQueue.main.async { 
                    self.pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
                }
            }
        }
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        pendingOpearions.downloadQueue.isSuspended = isSuspended
    }
    
    func toggleFavoriteButton() {
        if !self.isFavorite.value {
            saveFavorite()
        } else {
            deleteFromFavorite()
        }
    }
}
