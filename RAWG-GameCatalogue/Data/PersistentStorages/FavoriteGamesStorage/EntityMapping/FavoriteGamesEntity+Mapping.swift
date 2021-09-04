//
//  FavoriteGamesEntity+Mapping.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import UIKit
import CoreData

extension FavoriteGames {
    convenience init(game: DetailGame, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        id = game.id ?? 0
        name = game.name ?? ""
        image = game.image?.jpegData(compressionQuality: 80)
        rating = game.rating ?? 0.0
        genre = game.genres ?? ""
        released = game.released
        createdAt = Date()
    }
}
extension FavoriteGames {
    func toDomain() -> Game {
        let game = Game(id: Int(id),
                        name: name,
                        imagePath: "",
                        released: released,
                        rating: rating,
                        description: "",
                        genres: genre)
        if let imageData = image {
            game.image = UIImage(data: imageData)
        }
        game.createdAt = createdAt
        return game
    }
}
