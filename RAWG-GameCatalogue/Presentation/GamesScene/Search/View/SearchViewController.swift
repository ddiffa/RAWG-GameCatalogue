//
//  SearchViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class SearchViewController: UICustomViewControllerWithScrollView {
    
    lazy var genreCollectionView: UICustomCollectionView = {
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
    
    let browseGenresLabel: UIHeaderLabel = {
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
        guard let viewModel = viewModel else {
            return
        }
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: SearchViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0)}
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0)}
    }
    
    override func setUpView() {
        super.setUpView()
        isHiddenLargeTitle = false
        navigationItem.searchController = _searchViewController
        navigationItem.titleMode("Search", mode: .automatic)
        containerView.addSubview(browseGenresLabel)
        containerView.addSubview(genreCollectionView)
    }
    
//    override func didTapRightButtonItem() {
//        viewModel?.didTapRightBarItem()
//    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            
            browseGenresLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            browseGenresLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            browseGenresLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            
            genreCollectionView.topAnchor.constraint(equalTo: browseGenresLabel.bottomAnchor, constant: 10),
            genreCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            genreCollectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            genreCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16)
        ])
    }
    
    private func updateItems() {
        self.genreCollectionView.reloadData()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        // MARK: - Show alert
    }
}
