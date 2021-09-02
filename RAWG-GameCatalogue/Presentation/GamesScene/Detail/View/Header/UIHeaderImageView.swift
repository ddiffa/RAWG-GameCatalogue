//
//  UIHeaderImageView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIHeaderImageView: UIView {
    
    private let _thumbnailView: UICustomImageView = {
        let view = UICustomImageView()
        return view
    }()
    
    private let _titleGames: UITitleLabel = {
        let view = UITitleLabel()
        view.numberOfLines = 4
        return view
    }()
    
    private let _genreGames: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        
        return view
    }()
    
    var titleText: String? {
        didSet {
            guard let data = titleText else { return }
            _titleGames.text = data
        }
    }
    
    var genreText: String? {
        didSet {
            guard let data = genreText else { return }
            _genreGames.text = data
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let data = image else {
                _thumbnailView.thumbnail.image = UIImage(named: "error")
                _thumbnailView.hideLoading()
                return
            }
            _thumbnailView.thumbnail.image = data
            
            if _thumbnailView.thumbnail.image != nil {
                _thumbnailView.hideLoading()
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
        addSubview(_thumbnailView)
        addSubview(_titleGames)
        addSubview(_genreGames)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _thumbnailView.topAnchor.constraint(equalTo: self.topAnchor),
            _thumbnailView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            _thumbnailView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            _thumbnailView.widthAnchor.constraint(equalToConstant: 150),
            _thumbnailView.heightAnchor.constraint(equalToConstant: 140),
            
            _titleGames.topAnchor.constraint(equalTo: self.topAnchor),
            _titleGames.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            _titleGames.leftAnchor.constraint(equalTo: self._thumbnailView.rightAnchor, constant: 8),
            
            _genreGames.topAnchor.constraint(equalTo: self._titleGames.bottomAnchor, constant: 8),
            _genreGames.leftAnchor.constraint(equalTo: self._thumbnailView.rightAnchor, constant: 8),
            _genreGames.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
    
}
