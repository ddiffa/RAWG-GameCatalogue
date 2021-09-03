//
//  UseCase.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation


public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
