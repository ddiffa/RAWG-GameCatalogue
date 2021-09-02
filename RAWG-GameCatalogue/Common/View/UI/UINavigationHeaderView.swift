//
//  UINavigationHeaderView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class UINavigationHeaderView: UIView {
    
    let profileButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
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
        
        addSubview(_headerLabel)
        addSubview(profileButton)
        
        profileButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            
            _headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            _headerLabel.rightAnchor.constraint(equalTo: profileButton.leftAnchor, constant: -16),
            _headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            
            profileButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            profileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            profileButton.widthAnchor.constraint(equalToConstant: 32),
            profileButton.heightAnchor.constraint(equalToConstant: 32),
            
        ])
    }
    
    @objc func didTapAction() {
        guard let didTap =  didTapHandle else { return }
        didTap()
    }

}
