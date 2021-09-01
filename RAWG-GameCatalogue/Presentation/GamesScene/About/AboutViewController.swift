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
    
    let profileImage: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "house")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleMode("About", mode: .never)
    }
    
    
    override func setUpView(showRighBarButtonItem: Bool) {
        super.setUpView(showRighBarButtonItem: showRighBarButtonItem)
        containerView.addSubview(profileImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descLabel)
    }
    
    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            profileImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 24),
            
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
        ])
    }
}
