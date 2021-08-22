//
//  BrowseGamesViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class BrowseGamesViewController: UICustomViewControllerWithScrollView {
    
    // MARK: - Initialization Views
    let _descLabel: UILabel = {
        let view = UILabel()
        view.text = "From modern multi-player action games to classics you can download for free."
        view.textColor = .white
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var _newReleaseLabel: UIHeaderView = {
        let view = UIHeaderView()
        view.text = "New Release"
        view.didTapHandle = {
            self.didTapSeeAllHandling(type: .newRelease)
        }
        return view
    }()
    
    lazy var _newReleaseTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var _topGamesLabel: UIHeaderView = {
        let view = UIHeaderView()
        view.text = "Top Games"
        view.didTapHandle = {
            self.didTapSeeAllHandling(type: .topGames)
        }
        return view
    }()
    
    lazy var _topGamesTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: - Properties
    var viewModel: BrowseGamesViewModel?
    
    // MARK: - View Controller Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel?.viewDidLoad()
    }
    
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: true)
        navigationItem.titleMode("Browse Games", mode: .never)
        navigationTitle.text = "Browse Games"
        containerView.addSubview(_descLabel)
        containerView.addSubview(_newReleaseLabel)
        containerView.addSubview(_newReleaseTableView)
        containerView.addSubview(_topGamesLabel)
        containerView.addSubview(_topGamesTableView)
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            
            _descLabel.topAnchor.constraint(equalTo: navigationTitle.bottomAnchor, constant: 4),
            _descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16.0),
            _descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16.0),
            
            _newReleaseLabel.topAnchor.constraint(equalTo: _descLabel.bottomAnchor, constant: 24.0),
            _newReleaseLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            _newReleaseLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            
            _newReleaseTableView.topAnchor.constraint(equalTo: _newReleaseLabel.bottomAnchor, constant: 10.0),
            _newReleaseTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            _newReleaseTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            
            _topGamesLabel.topAnchor.constraint(equalTo: _newReleaseTableView.bottomAnchor, constant: 10),
            _topGamesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            _topGamesLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            
            _topGamesTableView.topAnchor.constraint(equalTo: _topGamesLabel.bottomAnchor, constant: 10),
            _topGamesTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            _topGamesTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            _topGamesTableView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: 16.0)
        ])
    }
    
    override func didTapRightButtonItem() {
        super.didTapRightButtonItem()
        viewModel?.didTapRightBarItem()
    }
    
    private func didTapSeeAllHandling(type: SeeAllGamesType) {
        viewModel?.didTapSeeAll(type: type)
    }
    
}
