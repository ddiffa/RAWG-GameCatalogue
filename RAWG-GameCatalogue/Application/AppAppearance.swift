//
//  AppAppearance.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(named: ColorType.tabBar.rawValue)
        UINavigationBar.appearance().tintColor = UIColor(named: ColorType.active.rawValue)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barStyle = .black
    }
}
