//
//  ImageDownloader.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 30/08/21.
//

import UIKit

enum ImageDownloaderType {
    case game, detail, genre, none
}

class ImageDownloader: Operation {
    private var game: Game?
    private var genre: Genre?
    private var detailGame: DetailGame?
    private var detailGameDelegate: DetailGameDelegate?
    private var containerSize: CGSize
    private var type: ImageDownloaderType = .none
    
    init(game: Game, containerSize: CGSize) {
        self.game = game
        self.containerSize = containerSize
        type = .game
    }
    
    init(genre: Genre, containerSize: CGSize) {
        self.genre = genre
        self.containerSize = containerSize
        type = .genre
    }
    
    init(detailGame: DetailGame, delegate: DetailGameDelegate, containerSize: CGSize) {
        self.detailGame = detailGame
        self.detailGameDelegate = delegate
        self.containerSize = containerSize
        type = .detail
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        
        if type == .genre {
            
            guard let url = self.genre?.imageBackground, let imageData = try? Data(contentsOf: url) else {
                self.genre?.state = .failed
                return
            }
            
            handleGenreImage(imageData)
        }
        
        if type == .game {
            guard let url = self.game?.imagePath, let imageData = try? Data(contentsOf: url) else {
                self.game?.state = .failed
                return
            }
            
            handleGameImage(imageData)
        }
        
        if type == .detail {
            guard let urlString = self.detailGame?.backgroundImage,
                  let url = URL(string:  urlString),
                  let imageData = try? Data(contentsOf: url) else {
                self.detailGame?.state = .failed
                setImageDetailGame()
                return
            }
            handleDetailGameImage(imageData)
        }
    }
    
    private func handleGameImage(_ imageData: Data) {
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            self.game?.image = try? imageData.downsample(to: self.containerSize, scale: 1)
            self.game?.state = .downloaded
        } else {
            self.game?.image = nil
            self.game?.state = .failed
        }
    }
    
    private func handleGenreImage(_ imageData: Data) {
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            self.genre?.image = try? imageData.downsample(to: self.containerSize, scale: 1)
            self.genre?.state = .downloaded
        } else {
            self.genre?.image = nil
            self.genre?.state = .failed
        }
    }
    
    private func handleDetailGameImage(_ imageData: Data) {
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            self.detailGame?.image = try? imageData.downsample(to: self.containerSize, scale: 1)
            self.detailGame?.state = .downloaded
        } else {
            self.detailGame?.image = nil
            self.detailGame?.state = .failed
        }
        
        setImageDetailGame()
    }
    
    
    private func setImageDetailGame() {
        DispatchQueue.main.async {
            self.detailGameDelegate?.setThumbnailImage(detailGame: self.detailGame)
        }
    }
}


