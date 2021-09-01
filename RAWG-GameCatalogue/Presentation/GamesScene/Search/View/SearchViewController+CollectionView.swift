//
//  SearchViewController+CollectionView.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    fileprivate func startOperations(genre: Genre, indexPath: IndexPath) {
        if genre.state == .new {
            self.viewModel?.startDownloadImage(genre: genre, indexPath: indexPath) {
                self.genreCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionViewCell.identifier, for: indexPath) as? GenresCollectionViewCell, viewModel?.items.value.count ?? 0 > 0, let data = viewModel?.items.value[indexPath.item] {
            
            cell.image = data.image
            cell.title = data.name
            
            if data.state == .new {
                if !collectionView.isDragging && !collectionView.isDecelerating {
                    self.startOperations(genre: data, indexPath: indexPath)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectItem(at: indexPath.item)
    }
    
}
