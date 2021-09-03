//
//  UICircleImageView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 03/09/21.
//

import UIKit

class UICircleImageView: UIView {
    private lazy var circleImage: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var image: UIImage? {
        didSet {
            circleImage.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        setUpLayoutConstraint()
    }
    
    private func setUpView() {
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        addSubview(circleImage)
        
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            circleImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            circleImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            circleImage.topAnchor.constraint(equalTo: self.topAnchor),
            circleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
