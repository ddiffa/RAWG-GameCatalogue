//
//  AppDIContainer.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!, queryParameters: ["key": appConfiguration.apiKey])
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTrasnferService(with: apiDataNetwork)
    }()
    
    func makeGamesSceneDIContainer() -> GamesSceneDIContainer {
        let dependencies = GamesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        
        return GamesSceneDIContainer(dependencies: dependencies)
    }
}
