//
//  SeeAllViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class SeeAllViewController: UICustomViewControllerWithScrollView {
        
    let gamesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var gamesViewController: GamesViewController?
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleMode(titleString ?? "", mode: .never)
    }
    
    override func setUpView() {
        super.setUpView()
        isHiddenLargeTitle = true
        containerView.addSubview(gamesContainer)
        if let gamesViewController = gamesViewController {
            gamesViewController.delegate = self
            
            gamesViewController.view.translatesAutoresizingMaskIntoConstraints = false
            gamesContainer.addSubview(gamesViewController.view)
            
            NSLayoutConstraint.activate([
                gamesViewController.view.leftAnchor.constraint(equalTo: gamesContainer.leftAnchor),
                gamesViewController.view.rightAnchor.constraint(equalTo: gamesContainer.rightAnchor),
                gamesViewController.view.topAnchor.constraint(equalTo: gamesContainer.topAnchor),
                gamesViewController.view.bottomAnchor.constraint(equalTo: gamesContainer.bottomAnchor),
            ])
        }
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            gamesContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            gamesContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            gamesContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            gamesContainer.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
}

extension SeeAllViewController: GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool) {
        self.updateLoading(isLoading)
    }
    
    func getRootNavigationController() -> UINavigationController? {
        return self.navigationController
    }
}