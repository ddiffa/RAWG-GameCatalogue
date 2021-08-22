//
//  UIHeaderView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UIHeaderView: UIView {
    
    private let _seeAllButton: UIButton = {
        let view = UIButton()
        view.setTitle("See all", for: .normal)
        view.contentHorizontalAlignment = .right
        view.setTitleColor(UIColor(named: ColorType.active.rawValue), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _headerLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "4.8"
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
        addSubview(_seeAllButton)
        addSubview(_headerLabel)
        
        _seeAllButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _seeAllButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            _seeAllButton.leftAnchor.constraint(equalTo: _headerLabel.rightAnchor),
            _seeAllButton.topAnchor.constraint(equalTo: self.topAnchor),
            _seeAllButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _seeAllButton.widthAnchor.constraint(equalToConstant: 90),
            
            _headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            
        ])
    }
    
    @objc func didTapAction() {
        guard let didTap =  didTapHandle else { return }
        didTap()
    }

}
