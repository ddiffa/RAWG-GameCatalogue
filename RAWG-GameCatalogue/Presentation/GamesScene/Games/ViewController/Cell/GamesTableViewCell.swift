//
//  GamesTableViewCell.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class GamesTableViewCell: UITableViewCell {
    static let identifier = "GamesTableViewCell"
    
    let thumbnailView: UICustomImageView = {
        let view = UICustomImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UITitleLabel = {
        let view = UITitleLabel()
        return view
    }()
    
    private let yearAndCategoryLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        
        view.text = "2012 | Action"
        return view
    }()
    
    private let separator: UISeparatorView = {
        let view = UISeparatorView()
        
        return view
    }()
    
    private let ratingView: UIRatingView = {
        let view = UIRatingView()
        
        return view
    }()
    
    var game: Game? {
        didSet {
            guard let data = game else {
                return
            }
            
            titleLabel.text = data.name
            ratingView.ratingValue = data.rating
            thumbnailView.thumbnail.image = data.image
            yearAndCategoryLabel.text = "\(data.released ?? "1997") | \(data.genres ?? "-")"
            
            if thumbnailView.thumbnail.image != nil {
                thumbnailView.hideLoading()
            }
            
            if data.state == .none || data.state == .failed {
                thumbnailView.thumbnail.image = UIImage(named: "error")
                thumbnailView.hideLoading()
            }
        }
    }
    
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
        contentView.addSubview(thumbnailView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearAndCategoryLabel)
        contentView.addSubview(separator)
        contentView.addSubview(ratingView)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbnailView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            thumbnailView.widthAnchor.constraint(equalToConstant: 100),
            thumbnailView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
            
            yearAndCategoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            yearAndCategoryLabel.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 8),
            yearAndCategoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            ratingView.topAnchor.constraint(equalTo: yearAndCategoryLabel.bottomAnchor, constant: 2),
            ratingView.leftAnchor.constraint(equalTo: thumbnailView.rightAnchor, constant: 8),
            ratingView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),
            
            separator.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 12),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 124)
        ])
    }
    
}
