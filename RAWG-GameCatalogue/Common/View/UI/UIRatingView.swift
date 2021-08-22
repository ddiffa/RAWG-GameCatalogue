//
//  UIRatingView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UIRatingView: UIView {
    
    private let _imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = UIColor(named: ColorType.active.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _ratingLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.text = "4.8"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addSubview(_imageView)
        addSubview(_ratingLabel)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _imageView.topAnchor.constraint(equalTo: self.topAnchor),
            _imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _imageView.heightAnchor.constraint(equalToConstant: 24),
            _imageView.widthAnchor.constraint(equalToConstant: 24),
            
            _ratingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            _ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _ratingLabel.leftAnchor.constraint(equalTo: _imageView.rightAnchor, constant: 8),
            _ratingLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
