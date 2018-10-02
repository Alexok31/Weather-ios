//
//  weatherHelper.swift
//  weather
//
//  Created by Александр Харченко on 10.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation
import GooglePlaces

protocol CanRecieveFavoriteCity {
    func receiveData(nameCity: String, lat: Double, lon: Double)
}


extension CurrentWeatherViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
