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
        view.text = "From modern multi-player action games to classics you can download for free."
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
    
    // MARK: - View Controller Lifecyle
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: true)
        navigationItem.titleMode("Browse Games", mode: .never)
        navigationTitle.text = "Browse Games"
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
            
            descLabel.topAnchor.constraint(equalTo: navigationTitle.bottomAnchor, constant: 4),
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
        super.didTapRightButtonItem()
//        viewModel?.didTapRightBarItem()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else {
            return
        }
        //MARK: Show alert
    }
    
    private func updateLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            hideLoading()
        }
    }
}

extension BrowseGamesViewController: GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool) {
      updateLoading(isLoading)
    }
}
