//
//  CustomViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class UICustomViewControllerWithScrollView: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        view.frame = self.view.bounds
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var _loadingView: UILoadingView = {
        let view = UILoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var navigationTitle: UINavigationHeaderView = {
        let view = UINavigationHeaderView()
        view.didTapHandle = self.didTapRightButtonItem
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var isHiddenLargeTitle: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isHiddenLargeTitle {
            checkNavigationBar()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle =  .dark
        setUpView(showRighBarButtonItem: false)
        setUpLayoutConstraint()
    }
    
    func setUpView(showRighBarButtonItem: Bool) {
        isHiddenLargeTitle = showRighBarButtonItem
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        view.addSubview(_loadingView)
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(containerView)
        
        if showRighBarButtonItem {
            containerView.addSubview(navigationTitle)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func setUpLayoutConstraint() {
        
        let centerYAnchor = NSLayoutConstraint.init(item: _loadingView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([
            centerYAnchor,
            _loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            _loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0)
        ])
        
        if isHiddenLargeTitle {
            NSLayoutConstraint.activate([
            
                navigationTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                navigationTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
                navigationTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16)
            ])
        }
    }
    
    func didTapRightButtonItem() {
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkNavigationBar()
    }
    
    func checkNavigationBar() {
        let viewFrame = scrollView.convert(navigationTitle.bounds, from: navigationTitle)
        
        if !viewFrame.intersects(scrollView.bounds) {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func hideLoading() {
        _loadingView.isHidden = true
        scrollView.isHidden = false
    }
    
    func showLoading() {
        _loadingView.isHidden = false
        scrollView.isHidden = true
    }
}
