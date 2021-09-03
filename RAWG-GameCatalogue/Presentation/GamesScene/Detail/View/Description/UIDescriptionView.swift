//
//  UIPreviewScreenshootView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIDescriptionView: UIView {
    
    private let headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Description"
        return view
    }()
    
    private let descriptionLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.numberOfLines = 0
        return view
    }()
    
    var descriptionText: String? {
        didSet {
            guard let text = descriptionText else { return }
            descriptionLabel.text = text.html2String
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
        addSubview(descriptionLabel)
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
