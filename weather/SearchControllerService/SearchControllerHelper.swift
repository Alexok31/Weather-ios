//
//  SearchControllerHelper.swift
//  weather
//
//  Created by Александр Харченко on 10.09.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation
import GooglePlaces

class SearchControllerHelper {
    func searchView(_ resultSearchController: UISearchController, resultsViewController: GMSAutocompleteResultsViewController){
        let searchController = resultSearchController.searchBar
        searchController.placeholder =  "Enter city"
        searchController.tintColor = UIColor.white
        searchController.barStyle = .blackOpaque
        resultsViewController.tableCellBackgroundColor = UIColor.darkGray
        resultsViewController.primaryTextColor = .black
        resultsViewController.primaryTextHighlightColor = .white
        resultsViewController.secondaryTextColor = .lightText
        resultsViewController.tableCellSeparatorColor = UIColor.clear
    }
    
    func filter(_ resultsViewController: GMSAutocompleteResultsViewController){
        let filter =  GoogleHelper().filter
        filter.type = .city
        resultsViewController.autocompleteFilter = filter
    }

}
