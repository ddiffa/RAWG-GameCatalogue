//
//  AboutViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 23/08/21.
//

import UIKit

class AboutViewController: UICustomViewControllerWithScrollView {
    
    // MARK: - Views
    private let nameLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Diffa Dwi Desyawan"
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    private let descLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        view.text = "Learner @ Apple Developer Academy Indonesia"
        view.numberOfLines = 0
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
    
    // MARK: - Properties
    var viewModel: AboutProfileViewModel?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .about
        navigationItem.titleMode("About Me", mode: .never)
        bind()
        viewModel?.fetchData()
    }
    
    private func bind() {
        viewModel?.profile.observe(on: self) { [weak self] in
            self?.updateView(profile: $0)
        }
        
        viewModel?.isLoading.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
        
        viewModel?.isUpdated.observe(on: self) { [weak self] in self?.showToast(isUpdated: $0)
        }
    }
    
    override func setUpView() {
        super.setUpView()
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
    
    override func didTapRightButtonItem() {
        let vc = EditProfileViewController()
        vc.delegate = self
        vc.profile = viewModel?.profile.value
        self.present(vc, animated: true)
    }
    
    private func updateView(profile: Profile?) {
        guard let profile = profile else { return }
        self.nameLabel.text = profile.fullName
        self.descLabel.text = profile.jobTitle
        self.profileImage.image = UIImage(data: profile.profileImage)
    }
    
    private func showToast(isUpdated: Bool) {
        if isUpdated {
            showAlert(title: "Success",
                      message: "Your profile has been updated",
                      actionTitle: "Ok",
                      completion: { self.viewModel?.closeAlertUpdate() })
        }
    }
}

extension AboutViewController: EditProfileDelegate {
    func updateProfile(profile: Profile) {
        viewModel?.didSaveButton(profile: profile)
    }
}
