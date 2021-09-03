//
//  UIInformationView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 02/09/21.
//

import UIKit

class UIInformationView: UIView {
    
    private var informations: [Information] = Information.initialData()
    
    private let headersLabel: UIHeaderLabel = {
        let view = UIHeaderLabel()
        view.text = "Information"
        return view
    }()
    
    private lazy var informationTableView: UICustomTableView = {
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
        addSubview(headersLabel)
        addSubview(informationTableView)
        
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        
        NSLayoutConstraint.activate([
            headersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            headersLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            headersLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            informationTableView.topAnchor.constraint(equalTo: headersLabel.bottomAnchor, constant: 16),
            informationTableView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16),
            informationTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            informationTableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func reloadData() {
        informationTableView.reloadData()
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
