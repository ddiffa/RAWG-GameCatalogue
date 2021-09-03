//
//  UIRatingsAndReviewView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit
import Cosmos
class UIRatingsAndReviewView: UIView {
    
    private let headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Ratings and Review"
        
        return view
    }()
    
    private let ratingView: CosmosView = {
        let view = CosmosView()
        view.rating = 0.0
        view.settings.starSize = 24
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.filledColor = UIColor(named: ColorType.active.rawValue) ?? .orange
        view.settings.emptyBorderColor = UIColor(named: ColorType.active.rawValue) ?? .orange
        view.settings.emptyColor = UIColor(named: ColorType.primary.rawValue) ?? .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.text = "0.0"
        view.font = UIFont.boldSystemFont(ofSize: 48)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reviewCount: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        return view
    }()
    
    var reviewCountValue: Int? {
        didSet {
            guard let value = reviewCountValue else { return }
            reviewCount.text = "\(value) reviews"
        }
    }
    var ratingValue: Double? {
        didSet {
            guard let value = ratingValue else { return }
            ratingLabel.text = "\(value)"
            ratingView.rating = value
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
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headersLabel)
        addSubview(ratingView)
        addSubview(ratingLabel)
        addSubview(reviewCount)
        
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: self.headersLabel.bottomAnchor, constant: 16),
            ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ratingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            ratingLabel.widthAnchor.constraint(equalToConstant: 110),
            
            ratingView.leftAnchor.constraint(equalTo: self.ratingLabel.rightAnchor, constant: 16),
            ratingView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            ratingView.topAnchor.constraint(equalTo: self.headersLabel.bottomAnchor, constant: 24),
            
            
            reviewCount.leftAnchor.constraint(equalTo: self.ratingLabel.rightAnchor, constant: 16),
            reviewCount.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            reviewCount.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 2)
        ])
    }
}
