//
//  UICustomImageView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

final class UICustomImageView: UIView {
 
    let thumbnail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = .gray
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        backgroundColor = UIColor(named: ColorType.disable.rawValue)
        
        addSubview(thumbnail)
        addSubview(activityIndicator)
        
        
        let centerYAnchor = NSLayoutConstraint.init(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnail.leftAnchor.constraint(equalTo: self.leftAnchor),
            thumbnail.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            
            centerYAnchor,
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }

}
