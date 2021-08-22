//
//  UIDescriptionLabel.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UIDescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.textColor = UIColor(named: ColorType.unactive.rawValue)
        self.textAlignment = .left
        self.font = UIFont.boldSystemFont(ofSize: 14)
        self.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
