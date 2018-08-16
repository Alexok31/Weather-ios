//
//  GoogleServise.swift
//  weather
//
//  Created by Александр Харченко on 11.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//


import GooglePlaces

class GoogleHelper {
  
    var resultsViewController: GMSAutocompleteResultsViewController?
    var autocompleteResultsViewController = GMSAutocompleteResultsViewController()
    let filter = GMSAutocompleteFilter()
    
    
    func loadFirstPhotoForPlace(placeID: String, completion: @escaping ((UIImage) -> ())) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first{
                    
                    GMSPlacesClient.shared().loadPlacePhoto(firstPhoto, callback: {
                        (photo, error) -> Void in
                        if let error = error {
                            // TODO: handle the error.
                            print("Error: \(error.localizedDescription)")
                        } else {
                            completion(photo!)
                        }
                    })
                }
            }
        }
    }
}
