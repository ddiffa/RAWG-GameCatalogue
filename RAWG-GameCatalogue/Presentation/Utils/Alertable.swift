//
//  Alertable.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 03/09/21.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "Something went wrong", message: String, completion: @escaping(() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

