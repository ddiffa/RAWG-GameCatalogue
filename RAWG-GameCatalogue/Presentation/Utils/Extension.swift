//
//  Extension.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit

extension UINavigationItem {
    func titleMode(_ title: String, mode: LargeTitleDisplayMode) {
        self.title = title
        self.largeTitleDisplayMode = mode
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()

extension Date {
    func getYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = .current
        formatter.locale = .current
        return formatter.string(from: self)
    }
    
    func convert() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}

extension String {
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension Data {
    public func downsample(to frameSize: CGSize, scale: CGFloat) throws -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        
        return try self.withUnsafeBytes { (unsafeRawBufferPointer: UnsafeRawBufferPointer) -> UIImage in
            let unsafeBufferPointer = unsafeRawBufferPointer.bindMemory(to: UInt8.self)
            guard let unsafePointer = unsafeBufferPointer.baseAddress else {throw ImageRenderingError.unableToCreateThumbnail}
            
            let dataPtr = CFDataCreate(kCFAllocatorDefault, unsafePointer, self.count)
            guard let data = dataPtr else { throw ImageRenderingError.unableToCreateThumbnail }
            guard let imageSource = CGImageSourceCreateWithData(data, imageSourceOptions) else { throw ImageRenderingError.unableToCreateImageSource }
            
            return try createThumbnail(from: imageSource, size: frameSize, scale: scale)
        }
    }
}

private func createThumbnail(from imageSource: CGImageSource, size: CGSize, scale:CGFloat) throws -> UIImage {
    let maxDimensionInPixels = max(size.width, size.height) * scale
    let options = [
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceShouldCacheImmediately: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
    guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options) else { throw ImageRenderingError.unableToCreateThumbnail }
    return UIImage(cgImage: thumbnail)
}

extension Error {
    func getErrorMessage() -> String {
        if self.isInternetConnectionError {
            return NSLocalizedString("No internet connection, Please try again", comment: "")
        } else {
            return NSLocalizedString("Failed loading games data, Please Check your connection and try again", comment: "")
        }
    }
}
