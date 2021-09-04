//
//  FavoriteViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 05/09/21.
//

import Foundation

import UIKit

class FavoriteViewController: UICustomViewControllerWithScrollView {
    
    // MARK: - Views
    private let emptyLabel: UINoResultView = {
        let view = UINoResultView()
        view.text = "You don't have\nFavorite Games yet."
        return view
    }()
    
    var gamesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    var gamesViewController: GamesViewController?
    var viewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleMode("Favorites", mode: .automatic)
    }
    
    override func setUpView() {
        super.setUpView()
        containerView.addSubview(gamesContainer)
        containerView.addSubview(emptyLabel)
        if let gamesViewController = gamesViewController {
            gamesViewController.delegate = self
            gamesViewController.state = .favorite
            gamesViewController.view.translatesAutoresizingMaskIntoConstraints = false
            gamesContainer.addSubview(gamesViewController.view)
            
            NSLayoutConstraint.activate([
                gamesViewController.view.leftAnchor.constraint(equalTo: gamesContainer.leftAnchor),
                gamesViewController.view.rightAnchor.constraint(equalTo: gamesContainer.rightAnchor),
                gamesViewController.view.topAnchor.constraint(equalTo: gamesContainer.topAnchor),
                gamesViewController.view.bottomAnchor.constraint(equalTo: gamesContainer.bottomAnchor)
            ])
        }
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gamesContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            gamesContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            gamesContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            gamesContainer.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasScrolled {
            state = .main
        }
        gamesViewController?.fetchFavoriteGames()
    }
    
    override func didTapRightButtonItem() {
        viewModel?.didTapProfileMenu()
    }
}

extension FavoriteViewController: GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool) {
        self.updateLoading(isLoading)
    }
    
    func getRootNavigationController() -> UINavigationController? {
        return self.navigationController
    }
    
    func onEmptySearchResult(_ isEmpty: Bool) {
        emptyLabel.isHidden = !isEmpty
    }
}
