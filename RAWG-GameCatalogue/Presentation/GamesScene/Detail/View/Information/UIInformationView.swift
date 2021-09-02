//
//  UIInformationView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIInformationView: UIView {
    
    private var informations: [InformationModel] = [
        InformationModel(key: "Developers", value: ""),
        InformationModel(key: "Released", value: ""),
        InformationModel(key: "Playtime", value: ""),
        InformationModel(key: "Platforms", value: ""),
    ]
    
    private let _headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Information"
        return view
    }()
    
    private lazy var _informationTableView: UICustomTableView = {
        let view = UICustomTableView()
        view.register(UIInformationTableViewCell.self, forCellReuseIdentifier: UIInformationTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var developers: String? {
        didSet {
            guard let developers = developers else { return }
            informations[0].value = developers
        }
    }
    
    var released: String? {
        didSet {
            guard let released = released,
                  let date = dateFormatter.date(from: released)?.convert() else { return }
            informations[1].value = date
        }
    }
    
    var playtime: String? {
        didSet {
            guard let playtime = playtime else { return }
            informations[2].value = playtime
        }
    }
    
    var platforms: String? {
        didSet {
            guard let platforms = platforms else { return }
            informations[3].value = platforms
        }
    }
    
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
        addSubview(_headersLabel)
        addSubview(_informationTableView)
        
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            _headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            _headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            _headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            _informationTableView.topAnchor.constraint(equalTo: _headersLabel.bottomAnchor, constant: 16),
            _informationTableView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16),
            _informationTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            _informationTableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func reloadData() {
        _informationTableView.reloadData()
    }
}


extension UIInformationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UIInformationTableViewCell.identifier, for: indexPath) as? UIInformationTableViewCell {
            cell.titleText = informations[indexPath.row].key
            cell.valueText = informations[indexPath.row].value
            return cell
        }

        return UITableViewCell()
    }
}


class InformationModel {
    var key: String
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
