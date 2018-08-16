//
//  File.swift
//  weather
//
//  Created by Александр Харченко on 26.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation

struct CurrentTempStructure: Decodable {
    var current_observation :Current_observationStructure
}

struct Current_observationStructure: Decodable {
    var weather : String
    var temp_c : Double
    var relative_humidity : String
    var feelslike_c : String
    var icon_url : String
    var icon : String
    var wind_kph : Double
}
