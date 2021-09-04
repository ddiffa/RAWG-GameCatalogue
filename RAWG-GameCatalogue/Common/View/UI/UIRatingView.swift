//
//  UIRatingView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UIRatingView: UIView {
    
    // MARK: - Views
    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = UIColor(named: ColorType.active.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.text = "4.8"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    var ratingValue: Double? {
        didSet {
            guard let value = ratingValue else { return }
            ratingLabel.text = "\(value)"
        }
    }
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(starImageView)
        addSubview(ratingLabel)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            starImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            starImageView.topAnchor.constraint(equalTo: self.topAnchor),
            starImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            starImageView.heightAnchor.constraint(equalToConstant: 24),
            starImageView.widthAnchor.constraint(equalToConstant: 24),
            
            ratingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ratingLabel.leftAnchor.constraint(equalTo: starImageView.rightAnchor, constant: 8),
            ratingLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
