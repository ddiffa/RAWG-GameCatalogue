//
//  GenresCollectionViewCell.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "GenresCollectionViewCell"
    
    private let thumbnailView: UICustomImageView = {
        let view = UICustomImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 4, height: 4)

        return view
    }()
    
    var title: String? {
        didSet {
            guard let value = title else { return }
            titleLabel.text = value
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let value = image else { return }
            thumbnailView.image = value
        
            if thumbnailView.image != nil {
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
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
