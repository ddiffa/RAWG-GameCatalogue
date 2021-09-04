//
//  SearchViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class SearchViewController: UICustomViewControllerWithScrollView {
    
    // MARK: - Views
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
    
    private let browseGenresLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Browse Genres"
        return view
    }()
    
    private lazy var searchViewController: UISearchController = {
        let view = UISearchController(searchResultsController: resultSearchVC)
        view.searchResultsUpdater = self
        view.searchBar.delegate = self
        view.searchBar.placeholder = "Grand Theft Auto V"
        return view
    }()
    
    // MARK: - Properties
    var viewModel: SearchViewModel?
    var resultSearchVC: ResultSearchViewController?
    
    // MARK: - View Controller Lifecycle
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
        viewModel.error.observe(on: self) { [weak self] in
            self?.showError($0, completion: { self?.viewModel?.viewDidLoad() })
        }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0)}
    }
    
    override func setUpView() {
        super.setUpView()
        navigationItem.searchController = searchViewController
        containerView.addSubview(browseGenresLabel)
        containerView.addSubview(genreCollectionView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasScrolled {
            state = .main
        }
        navigationItem.titleMode("Search", mode: .automatic)
        viewModel?.toggleSuspendOperations(isSuspended: false)
    }
    
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
    
    override func didTapRightButtonItem() {
        self.viewModel?.didTapRightBarItem()
    }
    
    private func updateItems() {
        self.genreCollectionView.reloadData()
    }
}
