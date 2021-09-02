//
//  Games.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit


class Game: Equatable, Identifiable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return false
    }
    
    typealias Identifier = Int?
    let id: Identifier
    let name: String?
    let imagePath: URL?
    let released: String?
    let rating: Double?
    let description: String?
    let genres: String?
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(id: Identifier, name: String?, imagePath: String?, released: String?, rating: Double?, description: String?, genres: String?) {
        self.id = id
        self.name = name
        let url = imagePath ?? ""
        self.imagePath = URL(string: url)
        self.released = dateFormatter.date(from: released ?? "")?.getYear()
        self.rating = rating
        self.description = description
        self.genres = genres
    }
}


class GamesPage: Equatable {
    static func == (lhs: GamesPage, rhs: GamesPage) -> Bool {
        return false
    }
    
    let count: Int?
    let next: String?
    let previous: String?
    
    let games: [Game]
    
    init(count: Int?, next: String?, previous: String?, games: [Game]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.games = games
    }
}
