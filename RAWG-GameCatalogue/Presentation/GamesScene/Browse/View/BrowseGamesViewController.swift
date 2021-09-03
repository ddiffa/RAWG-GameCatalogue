//
//  BrowseGamesViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class BrowseGamesViewController: UICustomViewControllerWithScrollView {
    
    // MARK: - Initialization Views
    let descLabel: UILabel = {
        let view = UILabel()
        view.text = "From modern multi-player action games to classics you can you can find here."
        view.textColor = .white
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var allGamesLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "All Games"
        return view
    }()
    
    var gamesContainer: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var gamesViewController: GamesViewController?
    var viewModel: BrowseGamesViewModel?
    
    // MARK: - View Controller Lifecyle
    override func setUpView() {
        super.setUpView()
        isHiddenLargeTitle = false
        navigationItem.titleMode( "Browse Games", mode: .automatic)
        containerView.addSubview(descLabel)
        containerView.addSubview(allGamesLabel)
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
            
            descLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            
            allGamesLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 24.0),
            allGamesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            allGamesLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            
            gamesContainer.topAnchor.constraint(equalTo: allGamesLabel.bottomAnchor, constant: 10.0),
            gamesContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            gamesContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            gamesContainer.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    override func didTapRightButtonItem() {
        viewModel?.didTapProfileMenu()
    }
}

extension BrowseGamesViewController: GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool) {
        self.updateLoading(isLoading)
    }
    
    func getRootNavigationController() -> UINavigationController? {
        return self.navigationController
    }
}
