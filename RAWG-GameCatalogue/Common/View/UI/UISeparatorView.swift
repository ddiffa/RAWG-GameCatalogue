//
//  UISeparator.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

class UISeparatorView: UIView {
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
        backgroundColor = UIColor(named: ColorType.unactive.rawValue)
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        alpha = 0.5
    }
}
