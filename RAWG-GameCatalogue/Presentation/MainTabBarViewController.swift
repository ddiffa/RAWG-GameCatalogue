//
//  MainTabBarViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 21/08/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private var _viewControllers: [UIViewController] = []
    
    private let titles: [String] = ["Browse",
                                    "Favorites",
                                    "Search"]
    private let images: [String] = ["gamecontroller.fill",
                                    "suit.heart.fill",
                                    "magnifyingglass"]
    
    static func create(with viewControllers: [UIViewController]) -> MainTabBarViewController {
        let view = MainTabBarViewController()
        view._viewControllers = viewControllers
        view.addViewController()
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        
        tabBar.unselectedItemTintColor = UIColor(named: ColorType.unactive.rawValue)
        tabBar.barTintColor = UIColor(named: ColorType.tabBar.rawValue)
        tabBar.tintColor = UIColor(named: ColorType.active.rawValue)
        modalPresentationStyle = .fullScreen
    }
    
    private func addViewController() {
        
        viewControllers = _viewControllers
        
        guard let items = tabBar.items else { return }
        
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
            items[index].title = titles[index]
            items[index].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}
