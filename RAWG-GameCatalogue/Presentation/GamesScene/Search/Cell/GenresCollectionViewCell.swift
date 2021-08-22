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
    private let _imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let _titleLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        
        return view
    }()
    
    // MARK: - Properties
    var title: String? {
        didSet {
            guard let value = title else { return }
            _titleLabel.text = value
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let value = image else { return }
            _imageView.image = value
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
        contentView.addSubview(_imageView)
        contentView.addSubview(_titleLabel)
        contentView.backgroundColor = .blue
        contentView.clipsToBounds = true
        
        setUpLayoutConstraints()
    }
    
    private func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            _imageView.topAnchor.constraint(equalTo: self.topAnchor),
            _imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            _titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            _titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            _titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
