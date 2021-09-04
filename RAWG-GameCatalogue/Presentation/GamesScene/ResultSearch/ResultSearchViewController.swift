//
//  ResultSearchViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class ResultSearchViewController: UICustomViewControllerWithScrollView {
    
    private let emptyLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.text = "No Result"
        view.textAlignment = .center
        return view
    }()

    var gamesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var gamesViewController: GamesViewController?
    var rootNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .seeAll
    }
    
    override func setUpView() {
        super.setUpView()
        containerView.addSubview(gamesContainer)
        containerView.addSubview(emptyLabel)
        if let gamesViewController = gamesViewController {
            gamesViewController.delegate = self
            
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
            emptyLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            gamesContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            gamesContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            gamesContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            gamesContainer.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
    
    func updateSearchResult(query: String) {
        gamesViewController?.searchQuery = query
    }
    
    func clearData() {
        gamesViewController?.clearData()
    }
}

extension ResultSearchViewController: GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool) {
        updateLoading(isLoading)
    }
    
    func getRootNavigationController() -> UINavigationController? {
        return rootNavigationController
    }
    
    func onEmptySearchResult(_ isEmpty: Bool) {
        emptyLabel.isHidden = !isEmpty
    }
}
