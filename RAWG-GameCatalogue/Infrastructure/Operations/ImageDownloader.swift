//
//  ImageDownloader.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 30/08/21.
//

import UIKit

class ImageDownloader: Operation {
    private var _game: Game?
    private var _genre: Genre?
    
    private var isGenre: Bool = false
    
    init(game: Game) {
        _game = game
        isGenre = false
    }
    
    init(genre: Genre) {
        _genre = genre
        isGenre = true
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        
        if isGenre {
            
            guard let url = _genre?.imageBackground, let imageData = try? Data(contentsOf: url) else {
                return
            }
            
            handleGenreImage(imageData)
        } else {
            guard let url = _game?.imagePath, let imageData = try? Data(contentsOf: url) else {
                return
            }
            
            handleGameImage(imageData)
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
    
}


