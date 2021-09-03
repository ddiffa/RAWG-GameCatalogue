//
//  PendingOperations.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 30/08/21.
//

import Foundation

class PendingOperations {
    lazy var downloadInProgress: [IndexPath: Operation] = [:]
    
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        
        queue.name = "id.hellodiffa.rawg-gameCatalogue.download-image"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
}
