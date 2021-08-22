//
//  SearchViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class SearchViewController: UICustomViewControllerWithScrollView {
    
    private lazy var _genreCollectionView: UICustomCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: ((self.view.frame.size.width)/1.9) - 32,
                                 height: (self.view.frame.size.width/2.5) - 10)
        
        let view = UICustomCollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.frame = self.view.bounds
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        view.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
        return view
    }()
    
    private let _browseGenresLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Browse Genres"
        return view
    }()
    
    private lazy var _searchViewController: UISearchController = {
        let view = UISearchController(searchResultsController: ResultSearchViewController())
        view.searchResultsUpdater = self
        view.searchBar.delegate = self
        return view
    }()
    
    //MARK: - Properties
    var viewModel: SearchViewModel?
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: true)
        navigationItem.searchController = _searchViewController
        navigationItem.titleMode("Search", mode: .never)
        navigationTitle.text = "Search"
        containerView.addSubview(_browseGenresLabel)
        containerView.addSubview(_genreCollectionView)
    }
    
    override func didTapRightButtonItem() {
        viewModel?.didTapRightBarItem()
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            
            _browseGenresLabel.topAnchor.constraint(equalTo: navigationTitle.bottomAnchor, constant: 12),
            _browseGenresLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            _browseGenresLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            
            _genreCollectionView.topAnchor.constraint(equalTo: _browseGenresLabel.bottomAnchor, constant: 10),
            _genreCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            _genreCollectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            _genreCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16)
        ])
    }
}
