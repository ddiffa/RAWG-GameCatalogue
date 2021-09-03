//
//  SearchViewController+SearchController.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 22/08/21.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if text.isEmpty {
            resultSearchVC?.clearData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        resultSearchVC?.updateSearchResult(query: text)
    }
}
