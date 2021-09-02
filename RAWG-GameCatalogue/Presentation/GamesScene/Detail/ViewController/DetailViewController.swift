//
//  DetailViewController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

protocol DetailGameDelegate {
    func setThumbnailImage(detailGame: DetailGame?)
}

class DetailViewController: UICustomViewControllerWithScrollView {
    
    let headerView: UIHeaderImageView = {
        let view = UIHeaderImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let screenShootView: UIDescriptionView = {
        let view = UIDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ratingView: UIRatingsAndReviewView = {
        let view = UIRatingsAndReviewView()
        
        return view
    }()
    
    let informationView: UIInformationView = {
        let view = UIInformationView()
        return view
    }()
    
    var viewModel: DetailGamesViewModel?
    var gamesID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        guard let gamesID = self.gamesID else { return }
        navigationItem.titleMode("", mode: .never)
        bind()
        viewModel?.viewDidLoad(gamesID: gamesID)
    }

    override func setUpView() {
        super.setUpView()
        isHiddenLargeTitle = true
        containerView.addSubview(headerView)
        containerView.addSubview(screenShootView)
        containerView.addSubview(ratingView)
        containerView.addSubview(informationView)
    }

    override func setUpLayoutConstraint() {
        super.setUpLayoutConstraint()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            screenShootView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            screenShootView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            screenShootView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            ratingView.topAnchor.constraint(equalTo: screenShootView.bottomAnchor),
            ratingView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            ratingView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            informationView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16),
            informationView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            informationView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            informationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    private func bind() {
        viewModel?.items.observe(on: self) { [weak self] in
            guard let data = $0 else { return }
            self?.setUpValue(data)
        }
        viewModel?.error.observe(on: self) { [weak self] in self?.showError(error: $0) }
        viewModel?.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    }
    
    private func setUpValue(_ data: DetailGame) {
        headerView.titleText = data.name
        headerView.genreText = data.genres
        
        if data.state == .new {
            self.viewModel?.startDownloadImage(delegate: self) {
                
            }
        }
        
        ratingView.ratingValue = data.rating
        ratingView.reviewCountValue = data.reviewCount
        
        informationView.developers =  data.developers ?? "-"
        informationView.platforms = data.parentPlatform ?? "-"
        informationView.released = data.released ?? "-"
        informationView.playtime = "\(data.playTime ?? 0)h"
        informationView.reloadData()
        
        screenShootView.descriptionText = data.description
    }
    
    private func showError(error: String?) {
        
    }
    
}

extension DetailViewController: DetailGameDelegate {
    func setThumbnailImage(detailGame: DetailGame?) {
//        guard let detailGame = detailGame else { return }
        self.headerView.image = detailGame?.image
    }
}
