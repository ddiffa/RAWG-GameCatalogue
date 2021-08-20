//
//  AppConfiguration.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import Foundation


final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "apiKey") as? String else {
            fatalError("Api key must not be empty in plist")
        }
        
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
