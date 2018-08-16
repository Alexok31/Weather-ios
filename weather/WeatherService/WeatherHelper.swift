//
//  weatherHelper.swift
//  weather
//
//  Created by Александр Харченко on 10.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation
import GooglePlaces

protocol RecieveData {
    func canRecieve(lat: CLLocationDegrees, lon: CLLocationDegrees)
}
