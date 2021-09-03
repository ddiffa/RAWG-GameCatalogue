//
//  Information.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 03/09/21.
//

import Foundation

class Information {
    var key: String
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    static func initialData() -> [Information] {
        return [
            Information(key: "Developers", value: ""),
            Information(key: "Released", value: ""),
            Information(key: "Playtime", value: ""),
            Information(key: "Platforms", value: ""),
        ]
    }
}
