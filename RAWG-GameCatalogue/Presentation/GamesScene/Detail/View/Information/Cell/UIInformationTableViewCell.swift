//
//  UIInformationTableViewCell.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIInformationTableViewCell: UITableViewCell {
    static let identifier = "UIInformationTableViewCell"
    
    // MARK: - Views
    private let separator: UISeparatorView = {
        let view = UISeparatorView()
        
        return view
    }()
    
    private let keyLabel: UIDescriptionLabel = {
        let view = UIDescriptionLabel()
        
        return view
    }()
    
    private let valueLabel: UITitleLabel = {
        let view = UITitleLabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.numberOfLines = 0
        view.textAlignment = .right
        return view
    }()
    
    // MARK: - Properties
    var titleText: String? {
        didSet {
            guard let text = titleText else {  return }
            keyLabel.text = text
        }
    }
    
    var valueText: String? {
        didSet {
            guard let text = valueText else {  return }
            valueLabel.text = text
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: ColorType.primary.rawValue)
        addView()
        setUpLayoutConstraint()
    }
    
    private func addView() {
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(separator)
    }
    
    private func setUpLayoutConstraint() {
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            keyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            keyLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -6),
            keyLabel.widthAnchor.constraint(equalToConstant: 180),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            valueLabel.leftAnchor.constraint(equalTo: keyLabel.rightAnchor, constant: 8),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
            
            separator.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 6),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            separator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }
}
