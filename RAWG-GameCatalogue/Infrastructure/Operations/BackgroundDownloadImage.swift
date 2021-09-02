//
//  BackgroundDownloadImage.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import Foundation

class BackgroundDownloadImage: NSObject {
    
    var downloader: ImageDownloader? 
    let pendingOpearions = PendingOperations()
    
    func startDownloadImage(indexPath: IndexPath, completion: @escaping (ImageDownloader) -> Void) {
        guard pendingOpearions.downloadInProgress[indexPath] == nil, let downloader = self.downloader else { return }
        
        completion(downloader)
        pendingOpearions.downloadInProgress[indexPath] = downloader
        pendingOpearions.downloadQueue.addOperation(downloader)
    }
    
    func toggleSuspendOperations(isSuspended: Bool) {
        pendingOpearions.downloadQueue.isSuspended = isSuspended
    }

}
