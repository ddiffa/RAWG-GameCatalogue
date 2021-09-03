//
//  UICustomCollectionView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

final class UICustomCollectionView: UICollectionView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUpView()
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 32)
    }
    
    private func setUpView() {
        backgroundColor = UIColor(named: ColorType.primary.rawValue)
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
