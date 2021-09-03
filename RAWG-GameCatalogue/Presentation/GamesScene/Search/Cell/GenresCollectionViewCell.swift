//
//  GenresCollectionViewCell.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "GenresCollectionViewCell"
    
    // MARK: - Views
    private let thumbnailView: UICustomImageView = {
        let view = UICustomImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        
        return view
    }()
    
    // MARK: - Properties
    var title: String? {
        didSet {
            guard let value = title else { return }
            titleLabel.text = value
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let value = image else { return }
            thumbnailView.thumbnail.image = value
            
            if thumbnailView.thumbnail.image != nil {
                thumbnailView.hideLoading()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    private func setUpView() {
        
        contentView.layer.cornerRadius = 10
        contentView.addSubview(thumbnailView)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .blue
        contentView.clipsToBounds = true
        
        setUpLayoutConstraints()
    }
    
    private func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailView.leftAnchor.constraint(equalTo: self.leftAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnailView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}