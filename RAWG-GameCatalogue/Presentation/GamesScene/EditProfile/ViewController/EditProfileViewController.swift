//
//  EditProfileViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import UIKit

protocol EditProfileDelegate: AnyObject {
    func updateProfile(profile: Profile)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Views
    private let profileImage: UIImageView = {
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

    private let formFullName: UICustomTextField = {
        let view = UICustomTextField()
        view.header = "Full Name"
        view.text = "Diffa Dwi Desyawan"
        return view
    }()
    
    private let formJobTitle: UICustomTextField = {
        let view = UICustomTextField()
        view.header = "Job Title"
        view.text = "Learner @ Apple Developer Academy Indonesia"
        return view
    }()
    
    private lazy var changeImageButton: UIButton = {
        let view = UIButton()
        view.setTitle("Change Image", for: .normal)
        view.addTarget(self,
                       action: #selector(didTapChangeImage),
                       for: .touchUpInside)
        view.setTitleColor(UIColor(named: ColorType.active.rawValue),
                           for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerSegue: UIHeaderSegue = {
        let view = UIHeaderSegue()
        view.title = "Edit Profile"
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imagePicker: ImagePicker = {
        let view = ImagePicker()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    weak var delegate: EditProfileDelegate?
    var profile: Profile?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        setUpView()
        setUpLayoutConstraint()
        setUpData()
    }
    
    func setUpView() {
        view.addSubview(headerSegue)
        view.addSubview(profileImage)
        view.addSubview(changeImageButton)
        view.addSubview(formFullName)
        view.addSubview(formJobTitle)
    }
    
    func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            headerSegue.topAnchor.constraint(equalTo: view.topAnchor),
            headerSegue.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerSegue.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerSegue.heightAnchor.constraint(equalToConstant: 50),
            
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            profileImage.topAnchor.constraint(equalTo: headerSegue.bottomAnchor,
                                              constant: 24),
            
            changeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeImageButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor,
                                              constant: 8),
            
            formFullName.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 12),
            formFullName.leftAnchor.constraint(equalTo: view.leftAnchor),
            formFullName.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            formJobTitle.topAnchor.constraint(equalTo: formFullName.bottomAnchor, constant: 8),
            formJobTitle.leftAnchor.constraint(equalTo: view.leftAnchor),
            formJobTitle.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setUpData() {
        guard let profile = profile else { return }
        self.profileImage.image = UIImage(data: profile.profileImage)
        self.formFullName.text = profile.fullName
        self.formJobTitle.text = profile.jobTitle
    }
    
    @objc func didTapChangeImage() {
        imagePicker.show()
    }
}

extension EditProfileViewController: UIHeaderSegueDelegate {
    func didTapSaveButton() {
        if let jobTitle = formJobTitle.getTextFiledText,
           let fullName = formFullName.getTextFiledText,
           let imageData = profileImage.image?.jpegData(compressionQuality: 80) {
            let profile = Profile(profileImage: imageData,
                                  jobTitle: jobTitle,
                                  fullName: fullName)
            delegate?.updateProfile(profile: profile)
            self.dismiss(animated: true)
        }
    }
    
    func didTapCancelButton() {
        self.dismiss(animated: true)
    }
}

extension EditProfileViewController: ImagePickerDelegate {
    func imagePicker(present alert: UIAlertController) {
        self.present(alert, animated: true)
    }
    
    func imagePicker(present imagePicker: UIImagePickerController) {
        self.present(imagePicker, animated: true)
    }
    
    func imagePicker(didFinishPickingMedia selectedImage: UIImage) {
        dismiss(animated: true) {
            self.profileImage.image = selectedImage
        }
    }
}
