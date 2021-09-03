//
//  AboutViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class AboutViewController: UICustomViewControllerWithScrollView {
    
    let nameLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Diffa Dwi Desyawan"
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    let descLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.text = "Learner @ Apple Academy Indonesia"
        view.textAlignment = .center
        return view
    }()
    
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        view.image = UIImage(named: "profile")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleMode("About Me", mode: .never)
    }
    
    override func setUpView() {
        super.setUpView()
        isHiddenLargeTitle = true
        containerView.addSubview(profileImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descLabel)
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 24),
            
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ])
    }
}
