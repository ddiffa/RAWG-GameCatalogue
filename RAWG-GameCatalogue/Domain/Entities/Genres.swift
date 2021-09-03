//
//  Genres.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//
import UIKit

class Genre: Equatable, Identifiable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return false
    }
    
    typealias Identifier = Int?
    let id: Identifier
    let name: String?
    let imageBackground: URL?
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(id: Identifier, name: String?, imageBackground: String?) {
        self.id = id
        self.name = name
        let url = imageBackground ?? ""
        self.imageBackground = URL(string: url)
    }
}

class GenresPage: Equatable {
    static func == (lhs: GenresPage, rhs: GenresPage) -> Bool {
        return false
    }
    
    let count: Int?
    let next: String?
    let previous: String?
    
    let genres: [Genre]
    
    init(count: Int?, next: String?, previous: String?, genres: [Genre]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.genres = genres
    }
}
