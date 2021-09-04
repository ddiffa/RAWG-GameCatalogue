//
//  UINoResultView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 05/09/21.
//

import UIKit

class UINoResultView: UIView {
    
    // MARK: - Views
    private let descLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    // MARK: - Properties
    var text: String? {
        didSet {
            guard let text = text else { return }
            descLabel.text = text
        }
    }
    
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
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(descLabel)
    }
    
    private func setUpLayoutConstraint() {
        let centerYAnchor = NSLayoutConstraint
            .init(item: descLabel,
                  attribute: .centerY,
                  relatedBy: .equal,
                  toItem: self,
                  attribute: .centerY,
                  multiplier: 1.0,
                  constant: 0)
        
        NSLayoutConstraint.activate([
            centerYAnchor,
            descLabel.leftAnchor.constraint(equalTo: leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
