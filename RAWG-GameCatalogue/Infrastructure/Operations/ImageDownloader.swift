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
    private var _game: Game?
    private var _genre: Genre?
    private var _detailGame: DetailGame?
    private var _detailGameDelegate: DetailGameDelegate?
    
    private var type: ImageDownloaderType = .none
    
    init(game: Game) {
        _game = game
        type = .game
    }
    
    init(genre: Genre) {
        _genre = genre
        type = .genre
    }
    
    init(detailGame: DetailGame, delegate: DetailGameDelegate) {
        _detailGame = detailGame
        _detailGameDelegate = delegate
        type = .detail
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        
        if type == .genre {
            
            guard let url = _genre?.imageBackground, let imageData = try? Data(contentsOf: url) else {
                _genre?.state = .failed
                return
            }
            
            handleGenreImage(imageData)
        }
        
        if type == .game {
            guard let url = _game?.imagePath, let imageData = try? Data(contentsOf: url) else {
                _game?.state = .failed
                return
            }
            
            handleGameImage(imageData)
        }
        
        if type == .detail {
            guard let urlString = _detailGame?.backgroundImage,
                  let url = URL(string:  urlString),
                  let imageData = try? Data(contentsOf: url) else {
                _detailGame?.state = .failed
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
            _game?.image = UIImage(data: imageData)
            _game?.state = .downloaded
        } else {
            _game?.image = nil
            _game?.state = .failed
        }
    }
    
    private func handleGenreImage(_ imageData: Data) {
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            _genre?.image = UIImage(data: imageData)
            _genre?.state = .downloaded
        } else {
            _genre?.image = nil
            _genre?.state = .failed
        }
    }
    
    private func handleDetailGameImage(_ imageData: Data) {
        
        if isCancelled {
            return
        }
        
        if !imageData.isEmpty {
            _detailGame?.image = UIImage(data: imageData)
            _detailGame?.state = .downloaded
        } else {
            _detailGame?.image = nil
            _detailGame?.state = .failed
        }
        
        setImageDetailGame()
    }
    
    
    private func setImageDetailGame() {
        DispatchQueue.main.async {
            self._detailGameDelegate?.setThumbnailImage(detailGame: self._detailGame)
        }
    }
}


