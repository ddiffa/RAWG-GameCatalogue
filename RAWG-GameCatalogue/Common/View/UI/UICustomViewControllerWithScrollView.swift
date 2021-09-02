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
        view.backgroundColor = .white
        
        view.didTapHandle = self.didTapRightButtonItem
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isHiddenLargeTitle: Bool = false {
        didSet {
            self.navigationController?.navigationBar.prefersLargeTitles = isHiddenLargeTitle
            if isHiddenLargeTitle {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    var didTapProfileMenu: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle =  .dark
        setUpView()
        setUpLayoutConstraint()
    }
    
    func setUpView() {
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        view.addSubview(_loadingView)
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(containerView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(didTapRightButtonItem))
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
    }
    
    @objc private func didTapRightButtonItem() {
        (didTapProfileMenu ?? {})() 
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isHiddenLargeTitle {
            let magicalSafeAreaTop: CGFloat = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
            
            let offset = scrollView.contentOffset.y + (magicalSafeAreaTop - (navigationController?.navigationBar.frame.height ?? 0) )
            
            let alpha: CGFloat = 1 - ((offset) / magicalSafeAreaTop)
            
            if alpha > 0.9 {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(didTapRightButtonItem))
            } else {
                self.navigationController?.navigationBar.prefersLargeTitles = false
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func hideLoading() {
        _loadingView.isHidden = true
        scrollView.isHidden = false
    }
    
    func showLoading() {
        _loadingView.isHidden = false
        scrollView.isHidden = true
    }
    
    func updateLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            hideLoading()
        }
    }
}
