//
//  UIHeaderImageView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIHeaderImageView: UIView {
    
    private let thumbnailView: UICustomImageView = {
        let view = UICustomImageView()
        return view
    }()
    
    private let titleGames: UITitleLabel = {
        let view = UITitleLabel()
        view.numberOfLines = 4
        return view
    }()
    
    private let genreGames: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        
        return view
    }()
    
    var titleText: String? {
        didSet {
            guard let data = titleText else { return }
            titleGames.text = data
        }
    }
    
    var genreText: String? {
        didSet {
            guard let data = genreText else { return }
            genreGames.text = data
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let data = image else {
                thumbnailView.thumbnail.image = UIImage(named: "error")
                thumbnailView.hideLoading()
                return
            }
            thumbnailView.thumbnail.image = data
            
            if thumbnailView.thumbnail.image != nil {
                thumbnailView.hideLoading()
            }
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
        addSubview(thumbnailView)
        addSubview(titleGames)
        addSubview(genreGames)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnailView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            thumbnailView.widthAnchor.constraint(equalToConstant: contentImageSize.width),
            thumbnailView.heightAnchor.constraint(equalToConstant: contentImageSize.height),
            
            titleGames.topAnchor.constraint(equalTo: self.topAnchor),
            titleGames.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            titleGames.leftAnchor.constraint(equalTo: self.thumbnailView.rightAnchor, constant: 8),
            
            genreGames.topAnchor.constraint(equalTo: self.titleGames.bottomAnchor, constant: 8),
            genreGames.leftAnchor.constraint(equalTo: self.thumbnailView.rightAnchor, constant: 8),
            genreGames.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
    
    var contentImageSize: CGSize {
        get {
            return CGSize(width: 150, height: 140)
        }
    }
}
