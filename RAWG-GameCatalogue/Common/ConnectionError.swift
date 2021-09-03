//
//  ConnectionError.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation

public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError,
              error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
