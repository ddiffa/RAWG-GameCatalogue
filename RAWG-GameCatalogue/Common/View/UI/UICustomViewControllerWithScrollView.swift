//
//  CustomViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

enum ViewControllerState {
    case main, detail, about, seeAll
}

class UICustomViewControllerWithScrollView: UIViewController,
                                            UIScrollViewDelegate,
                                            Alertable {
    
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
    
    private lazy var loadingView: UILoadingView = {
        let view = UILoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var hasScrolled: Bool = false
    var state: ViewControllerState = .main {
        didSet {
            setUpNavigationBar()
        }
    }
    
    private var alphaProfileMenu: CGFloat {
        let magicalSafeAreaTop: CGFloat = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let offset = scrollView.contentOffset.y + (magicalSafeAreaTop - (navigationController?.navigationBar.frame.height ?? 0))
        let alpha: CGFloat = 1 - ((offset) / magicalSafeAreaTop)
        return alpha
    }
    
    private let profileImage = UIImage(systemName: "person.crop.circle")
    
    private lazy var profileButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: profileImage,
                        style: .plain,
                        target: self,
                        action: #selector(didTapRightButtonItem))
        return view
    }()
    
    private lazy var editProfileButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Edit",
                                   style: .plain,
                                   target: self,
                                   action: #selector(didTapRightButtonItem))
        return view
    }()
    
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
        view.addSubview(loadingView)
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(containerView)
    }
    
    func setUpLayoutConstraint() {
        let centerYAnchor = NSLayoutConstraint
            .init(item: loadingView,
                  attribute: .centerY,
                  relatedBy: .equal,
                  toItem: view,
                  attribute: .centerY,
                  multiplier: 1.0,
                  constant: 0)
        
        NSLayoutConstraint.activate([
            centerYAnchor,
            loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
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
    
    @objc func didTapRightButtonItem() {}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if state == .main {
            if alphaProfileMenu > 0.9 {
                hasScrolled = false
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.rightBarButtonItem = profileButton
            } else {
                hasScrolled = true
                self.navigationController?.navigationBar.prefersLargeTitles = false
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    
    func hideLoading() {
        loadingView.isHidden = true
        scrollView.isHidden = false
    }
    
    func showLoading() {
        loadingView.isHidden = false
        scrollView.isHidden = true
    }
    
    func updateLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            hideLoading()
        }
    }
    
    func showError(_ error: String, completion: @escaping() -> Void) {
        guard !error.isEmpty else {
            return
        }
        
        showAlert(title: "Something went wrong",
                  message: error,
                  actionTitle: "Try Again") {
            completion()
        }
    }
    
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = state == .main
        
        switch state {
            case .main:
                setUpMainBarItem()
            case .about:
                navigationItem.rightBarButtonItem = editProfileButton
            case .detail:
                navigationItem.rightBarButtonItem = nil
            case .seeAll:
                navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func setUpMainBarItem() {
        if alphaProfileMenu > 0.9 {
            self.navigationItem.rightBarButtonItem = profileButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}
