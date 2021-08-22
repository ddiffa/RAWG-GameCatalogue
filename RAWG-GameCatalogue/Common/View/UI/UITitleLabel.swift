//
//  UITitleLabel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UITitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.textColor = .white
        self.textAlignment = .left
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

