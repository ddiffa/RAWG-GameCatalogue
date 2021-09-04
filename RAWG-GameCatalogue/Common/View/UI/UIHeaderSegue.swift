//
//  UIHeaderSegue.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import UIKit

protocol UIHeaderSegueDelegate: AnyObject {
    func didTapCancelButton()
    func didTapSaveButton()
}

class UIHeaderSegue: UIView {
    
    // MARK: - Views
    private lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.barTintColor = UIColor(named: ColorType.tabBar.rawValue)
        view.pushItem(navigationItem, animated: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var navigationItem: UINavigationItem = {
        let view = UINavigationItem()
        
        view.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(didTapSaveButton))
        view.rightBarButtonItem?.tintColor = UIColor(named: ColorType.active.rawValue)
        
        view.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTapCancelButton))
        view.leftBarButtonItem?.tintColor = UIColor(named: ColorType.active.rawValue)
        
        return view
    }()
    
    // MARK: - Properties
    var title: String? {
        didSet {
            guard let title = title else { return }
            navigationItem.title = title
        }
    }
    
    weak var delegate: UIHeaderSegueDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        setUpLayoutConstraint()
    }
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(navigationBar)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.topAnchor),
            navigationBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func didTapSaveButton() {
        delegate?.didTapSaveButton()
    }
    
    @objc func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
}
