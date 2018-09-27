//
//  File.swift
//  weather
//
//  Created by Александр Харченко on 10.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//


import GooglePlaces


extension CurrentWeatherViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
       
        resultSearchController?.isActive = false
        let latitude = place.coordinate.latitude
        let longitude = place.coordinate.longitude
        weatherData(lat: latitude, lon: longitude)
        LocationHelper().cityOnTheMapView(lat: latitude, lon: longitude) { (region) in
            GoogleHelper().loadFirstPhotoForPlace(placeID: place.placeID, completion: { (photo) in
                
                DispatchQueue.main.async {
                    self.cityLabel.text = place.name
                    self.mapView.setRegion(region, animated: true)
                    self.photoImageView.image = photo
                }
            })
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
