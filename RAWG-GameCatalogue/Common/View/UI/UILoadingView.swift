//
//  UILoadingView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class UILoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .white
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.text = "Please wait"
        view.textAlignment = .center
        return view
    }()
    
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
        addSubview(activityIndicator)
        addSubview(descLabel)
    }
    
    private func setUpLayoutConstraint() {
        let centerYAnchor = NSLayoutConstraint
            .init(item: activityIndicator,
                  attribute: .centerY,
                  relatedBy: .equal,
                  toItem: self,
                  attribute: .centerY,
                  multiplier: 0.8,
                  constant: 0)
        
        NSLayoutConstraint.activate([
            centerYAnchor,
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: rightAnchor),
            descLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10)
        ])
    }
}
