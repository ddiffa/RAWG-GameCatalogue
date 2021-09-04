//
//  UICustomTextView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import UIKit

class UICustomTextField: UIView {
    
    // MARK: - Views
    private let titleLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        return view
    }()
    
    private let textField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.isEnabled = true
        view.backgroundColor = UIColor(named: ColorType.textField.rawValue)
        view.textColor = .white
        view.autocorrectionType = .no
        view.returnKeyType = .done
        view.keyboardType = .asciiCapable
        view.tintColor = UIColor(named: ColorType.active.rawValue)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    var header: String? {
        didSet {
            guard let header = header else { return }
            titleLabel.text = header
        }
    }
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            textField.text = text
        }
    }
    
    var getTextFiledText: String? {
        return textField.text
    }
    
    // MARK: - View Lifecycle
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            textField.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

}
