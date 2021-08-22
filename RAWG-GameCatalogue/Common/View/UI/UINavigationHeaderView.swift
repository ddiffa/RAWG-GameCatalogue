//
//  UINavigationHeaderView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class UINavigationHeaderView: UIView {
    
    private let _profileButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "gamer"), for: .normal)
        view.tintColor = UIColor(named: ColorType.active.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _headerLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.font = UIFont.boldSystemFont(ofSize: 28)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UISeparatorView = {
       let view = UISeparatorView()
        return view
    }()
    var didTapHandle: (() -> Void)?
    
    var text: String? {
        didSet {
            guard let value = text else { return }
            _headerLabel.text = value
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(_profileButton)
        addSubview(_headerLabel)
        addSubview(separatorView)
        
        _profileButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _profileButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            _profileButton.leftAnchor.constraint(equalTo: _headerLabel.rightAnchor),
            _profileButton.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10),
            _profileButton.widthAnchor.constraint(equalToConstant: 32),
            _profileButton.heightAnchor.constraint(equalToConstant: 32),
            
            _headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _headerLabel.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10),
            _headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
    }
    
    @objc func didTapAction() {
        guard let didTap =  didTapHandle else { return }
        didTap()
    }

}
