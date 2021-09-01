////
////  BackgroundDownloadImage.swift
////  RAWG-GameCatalogue
////
////  Created by Diffa Desyawan on 02/09/21.
////
//
//import Foundation
//
//
//class BackgroundDownloadImage: NSObject {
//    static let shared = BackgroundDownloadImage()
//    
//    let _pendingOpearions = PendingOperations()
//    
//    func startDownloadImage<T>(data: T, indexPath: IndexPath, completion: @escaping () -> Void) {
//        guard _pendingOpearions.downloadInProgress[indexPath] == nil else { return }
//        
//        let downloader = ImageDownloader(game: data)
//        
//        downloader.completionBlock = {
//            if downloader.isCancelled  { return }
//            
//            DispatchQueue.main.async {
//                self._pendingOpearions.downloadInProgress.removeValue(forKey: indexPath)
//                completion()
//            }
//        }
//        
//        _pendingOpearions.downloadInProgress[indexPath] = downloader
//        _pendingOpearions.downloadQueue.addOperation(downloader)
//    }
//    
//    func toggleSuspendOperations(isSuspended: Bool) {
//        _pendingOpearions.downloadQueue.isSuspended = isSuspended
//    }
//
//}
