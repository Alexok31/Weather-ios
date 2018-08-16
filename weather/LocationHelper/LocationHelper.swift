//
//  MapKitHelper.swift
//  weather
//
//  Created by Александр Харченко on 24.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation
import MapKit


class LocationHelper {
    
    let locationMeneger = CLLocationManager()
    var geocoder: CLGeocoder!
    var placemark: CLPlacemark!
    
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation],completion: @escaping ((MKCoordinateRegion, String, String) -> ())) {
        let location = locations[0] //.last
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegionMake(myLocation, span)
        manager.stopUpdatingLocation()
        let geoCoder = CLGeocoder()
        // Definition of the name of the foundation from the geolocation
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            completion(region, placeMark.locality!, placeMark.country!)
            
        })
    }
    
    func cityOnTheMapView(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping ((MKCoordinateRegion) -> ())) {
        // approximation of annotation
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake((lat), (lon))
        let span = MKCoordinateSpanMake(0.15, 0.15)
        let region = MKCoordinateRegionMake(coordinate, span)
        completion(region)
    }
}

