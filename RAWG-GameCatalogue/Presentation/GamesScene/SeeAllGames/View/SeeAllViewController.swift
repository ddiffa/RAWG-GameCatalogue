//
//  SeeAllViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class SeeAllViewController: UICustomViewControllerWithScrollView {
        
    lazy var _gamesTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleMode("See all Missions", mode: .never)
    }
    
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: false)
        containerView.addSubview(_gamesTableView)
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            _gamesTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            _gamesTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            _gamesTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            _gamesTableView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
}
