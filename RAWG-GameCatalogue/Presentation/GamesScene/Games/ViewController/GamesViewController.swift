//
//  GamesViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

enum GamesViewControllerState {
    case search, favorite, none
}

protocol GamesViewControllerDelegate: AnyObject {
    func onLoading(_ isLoading: Bool)
    func getRootNavigationController() -> UINavigationController?
    func onEmptySearchResult(_ isEmpty: Bool)
}

class GamesViewController: UIViewController, Alertable {
    
    // MARK: - Views
    lazy var gamesTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.register(GamesTableViewCell.self, forCellReuseIdentifier: GamesTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: - Properties
    var viewModel: GamesViewModel?
    weak var delegate: GamesViewControllerDelegate?
    var genre: String = ""
    
    var searchQuery: String = "" {
        didSet {
            if !searchQuery.isEmpty {
                viewModel?.fetchData(genre: genre, searchQueary: searchQuery)
            }
        }
    }
    
    var state: GamesViewControllerState = .none
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayoutConstraint()
        bind()
        if state == .none {
            viewModel?.fetchData(genre: genre, searchQueary: searchQuery)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    private func bind() {
        viewModel?.items.observe(on: self) { [weak self] _ in self?.updateItems()}
        viewModel?.error.observe(on: self) { [weak self] in self?.showError($0)}
        viewModel?.loading.observe(on: self) { [weak self] in self?.delegate?.onLoading($0)
        }
    }
    
    private func setUpView() {
        view.addSubview(gamesTableView)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            gamesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            gamesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            gamesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            gamesTableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    private func updateItems() {
        if viewModel?.items.value.count ?? 0 > 0 {
            self.delegate?.onEmptySearchResult(false)
        } else {
            self.delegate?.onEmptySearchResult(true)
        }
        gamesTableView.reloadData()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else {
            return
        }
        
        showAlert(title: "Something went wrong",
                  message: error,
                  actionTitle: "Try Again") {
            if self.state == .favorite {
                self.viewModel?.fetchFavoritesData()
            } else {
                self.viewModel?.fetchData(genre: self.genre,
                                          searchQueary: self.searchQuery)
            }
        }
    }
    
    func resumeOperations() {
        viewModel?.toggleSuspendOperations(isSuspended: false)
    }
    
    func suspendOperations() {
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    func clearData() {
        viewModel?.items.value.removeAll()
        updateItems()
    }
    
    func fetchFavoriteGames() {
        if state == .favorite {
            viewModel?.fetchFavoritesData()
        }
    }
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        suspendOperations()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resumeOperations()
    }
    
    fileprivate func startOperations(game: Game, indexPath: IndexPath) {
        self.viewModel?.startDownloadImage(game: game,
                                           indexPath: indexPath,
                                           containerSize: gamesTableView.contentSize,
                                           completion: {
                                            if indexPath.row < self.viewModel?.items.value.count ?? 0 {
                                                self.gamesTableView.reloadRows(at: [indexPath], with: .none)
                                            }
                                           })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier, for: indexPath) as? GamesTableViewCell {
            
            if viewModel?.items.value.count ?? 0 > 0,
               let game = viewModel?.items.value[indexPath.row] {
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
        if let id = viewModel?.items.value[indexPath.row].id,
           let navController = delegate?.getRootNavigationController() {
            viewModel?.didSelectItem(navController: navController, at: "\(id)")
        }
    }
    
}
