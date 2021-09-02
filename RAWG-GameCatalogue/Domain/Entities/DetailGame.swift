//
//  DetailGame.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

struct DetailGame {
    let id: Int64?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let playTime: Int?
    let parentPlatform: String?
    let genres: String?
    let developers: String?
    let reviewCount: Int?
    
    var image: UIImage?
    var state: DownloadState = .new
}
