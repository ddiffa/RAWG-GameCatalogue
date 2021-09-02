//
//  UIPreviewScreenshootView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIDescriptionView: UIView {
    
    private let _headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Description"
        return view
    }()
    
    private let _descriptionLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.numberOfLines = 0
        return view
    }()
    
    var descriptionText: String? {
        didSet {
            guard let text = descriptionText else { return }
            _descriptionLabel.text = text.html2String
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
        addSubview(_descriptionLabel)
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            _headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            _headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            _descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            _descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            _descriptionLabel.topAnchor.constraint(equalTo: _headersLabel.bottomAnchor, constant: 8),
            _descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
