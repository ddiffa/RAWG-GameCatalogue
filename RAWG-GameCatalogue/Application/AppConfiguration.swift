//
//  AppConfiguration.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import Foundation


final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
            fatalError("Api key must not be empty in plist")
        }
        
        return apiKey
    }()
    
    let apiBaseUrl: String = "https://api.rawg.io/api/games"
}
