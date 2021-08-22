//
//  GamesTableViewCell.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class GamesTableViewCell: UITableViewCell {
    static let identifier = "GamesTableViewCell"
    
    private let _imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _titleLabel: UITitleLabel = {
        let view = UITitleLabel()
        return view
    }()
    
    private let _yearAndCategoryLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        
        view.text = "2012 | Action"
        return view
    }()
    
    private let _separator: UISeparatorView = {
        let view = UISeparatorView()
        
        return view
    }()
    
    private let _ratingView: UIRatingView = {
        let view = UIRatingView()
        
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        addView()
        setUpLayoutConstraint()
    }
    
    private func addView() {
        contentView.addSubview(_imageView)
        contentView.addSubview(_titleLabel)
        contentView.addSubview(_yearAndCategoryLabel)
        contentView.addSubview(_separator)
        contentView.addSubview(_ratingView)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            _imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            _imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            _imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            _imageView.widthAnchor.constraint(equalToConstant: 100),
            
            _titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            _titleLabel.leftAnchor.constraint(equalTo: _imageView.rightAnchor, constant: 8),
            _titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
            
            _yearAndCategoryLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 4),
            _yearAndCategoryLabel.leftAnchor.constraint(equalTo: _imageView.rightAnchor, constant: 8),
            _yearAndCategoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            _ratingView.topAnchor.constraint(equalTo: _yearAndCategoryLabel.bottomAnchor, constant: 4),
            _ratingView.leftAnchor.constraint(equalTo: _imageView.rightAnchor, constant: 8),
            _ratingView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),
            
            _separator.topAnchor.constraint(equalTo: _ratingView.bottomAnchor, constant: 12),
            _separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            _separator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            _separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 124)
        ])
    }
    
    func setUpView(title: String){
        _titleLabel.text = title
        _imageView.image = UIImage(systemName: "house")
    }
    
}
