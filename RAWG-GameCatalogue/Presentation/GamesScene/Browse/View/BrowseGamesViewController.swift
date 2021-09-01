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
    
    lazy var gamesTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: - Properties
    var viewModel: BrowseGamesViewModel?
    let pendingOpearions = PendingOperations()
    // MARK: - View Controller Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            bind(to: viewModel)
            viewModel.viewDidLoad()
        }
    }
    
    private func bind(to viewModel: BrowseGamesViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems()}
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0)}
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0 == .show)}
    }
    
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: true)
        navigationItem.titleMode("Browse Games", mode: .never)
        navigationTitle.text = "Browse Games"
        containerView.addSubview(descLabel)
        containerView.addSubview(allGamesLabel)
        containerView.addSubview(gamesTableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.toggleSuspendOperations(isSuspended: true)
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
            
            gamesTableView.topAnchor.constraint(equalTo: allGamesLabel.bottomAnchor, constant: 10.0),
            gamesTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            gamesTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            gamesTableView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    override func didTapRightButtonItem() {
        super.didTapRightButtonItem()
        viewModel?.didTapRightBarItem()
    }
    
    private func didTapSeeAllHandling(type: SeeAllGamesType) {
        viewModel?.didTapSeeAll(type: type)
    }
    
    private func updateItems() {
        print("Data: \(viewModel?.items.value.count)")
        gamesTableView.reloadData()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else {
            return
        }
        //MARK: Show alert
    }
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel?.toggleSuspendOperations(isSuspended: false)
    }
    
    private func updateLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            hideLoading()
        }
    }

}

extension BrowseGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func startOperations(game: Game, indexPath: IndexPath) {
        if game.state == .new {
            self.viewModel?.startDownloadImage(game: game, indexPath: indexPath) {
                self.gamesTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier, for: indexPath) as? GamesTableViewCell {
            
            if viewModel?.items.value.count ?? 0 > 0, let game = viewModel?.items.value[indexPath.row] {
                
                cell.game = game
                
                if game.state == .new {
                    if !tableView.isDragging && !tableView.isDecelerating {
                        self.startOperations(game: game, indexPath: indexPath)
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(at: indexPath.row)
    }
    
}
