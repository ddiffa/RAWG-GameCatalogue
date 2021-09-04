//
//  Alertable.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 03/09/21.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   actionTitle: String,
                   completion: @escaping(() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in completion() }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
