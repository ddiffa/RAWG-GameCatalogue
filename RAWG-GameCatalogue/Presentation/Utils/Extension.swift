//
//  Extension.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit

extension UINavigationItem {
    
    func titleMode(_ title: String, mode: LargeTitleDisplayMode) {
        self.title = title
        self.largeTitleDisplayMode = mode
    }
}
