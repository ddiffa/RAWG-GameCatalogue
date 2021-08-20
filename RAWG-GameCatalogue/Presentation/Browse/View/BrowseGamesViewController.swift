//
//  BrowseGamesViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 20/08/21.
//

import UIKit

class BrowseGamesViewController: UIViewController {
    
    private var _viewModel: BrowseGamesViewModel?
    
    static func create(with viewModel: BrowseGamesViewModel) -> BrowseGamesViewController {
        let view = BrowseGamesViewController()
        view._viewModel = viewModel
        
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _viewModel?.viewDidLoad()
    }
    
    
    private func setupViews() {
        
    }
}
