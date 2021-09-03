//
//  UICustomTableView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

final class UICustomTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 32)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUpView()
    }
    
    private func setUpView() {
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
    }
}
