//
//  UIRatingsAndReviewView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIRatingsAndReviewView: UIView {
    
    private let _headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Ratings and Review"
        
        return view
    }()
    
    private let _imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = UIColor(named: ColorType.active.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _ratingLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.text = "0.0"
        view.font = UIFont.boldSystemFont(ofSize: 48)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _reviewCount: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        return view
    }()
    
    var reviewCountValue: Int? {
        didSet {
            guard let value = reviewCountValue else { return }
            _reviewCount.text = "\(value) reviews"
        }
    }
    var ratingValue: Double? {
        didSet {
            guard let value = ratingValue else { return }
            _ratingLabel.text = "\(value)"
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
        addSubview(_headersLabel)
        addSubview(_imageView)
        addSubview(_ratingLabel)
        addSubview(_reviewCount)
        
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            _headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            _headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            _ratingLabel.topAnchor.constraint(equalTo: _headersLabel.bottomAnchor, constant: 16),
            _ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _ratingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            _imageView.leftAnchor.constraint(equalTo: self._ratingLabel.rightAnchor, constant: 16),
            _imageView.topAnchor.constraint(equalTo: _headersLabel.bottomAnchor, constant: 24),
            _imageView.heightAnchor.constraint(equalToConstant: 24),
            _imageView.widthAnchor.constraint(equalToConstant: 24),
            
            _reviewCount.leftAnchor.constraint(equalTo: _ratingLabel.rightAnchor, constant: 16),
//            _reviewCount.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            _reviewCount.topAnchor.constraint(equalTo: _imageView.bottomAnchor, constant: 2)
        ])
    }
}
