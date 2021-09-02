//
//  GamesViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

protocol GamesViewControllerDelegate {
    func onLoading(_ isLoading: Bool)
}

class GamesViewController: UIViewController {
    
    // MARK: - Initialization Views
    lazy var gamesTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        return view
    }()
    
    // MARK: - Properties
    var viewModel: GamesViewModel?
    var delegate: GamesViewControllerDelegate?
    var genre: String = ""
    var searchQuery: String = ""
    // MARK: - View Controller Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpLayoutConstraint()
        bind()
        viewModel?.viewDidLoad(genre: genre, searchQueary: searchQuery)
    }
    
    private func bind() {
        viewModel?.items.observe(on: self) { [weak self] _ in self?.updateItems()}
        viewModel?.error.observe(on: self) { [weak self] in self?.showError($0)}
        viewModel?.loading.observe(on: self) { [weak self] in self?.delegate?.onLoading($0)}
    }
    
    func setUpView() {
        view.addSubview(gamesTableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            gamesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            gamesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            gamesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            gamesTableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    private func didTapSeeAllHandling(type: SeeAllGamesType) {
        viewModel?.didTapSeeAll(type: type)
    }
    
    private func updateItems() {
        gamesTableView.reloadData()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else {
            return
        }
        //MARK: Show alert
    }
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel?.toggleSuspendOperations(isSuspended: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel?.toggleSuspendOperations(isSuspended: false)
    }
    
    
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
