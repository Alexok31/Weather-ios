//
//  File.swift
//  weather
//
//  Created by Александр Харченко on 23.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation

struct HourDayStructure: Decodable {
    var hourly_forecast : [Hourly_forecastSructure]
}

struct Hourly_forecastSructure: Decodable {
    var icon_url : String
    var FCTTIME : FCTTIMEStructure
    var temp : TampStructure
    
}

struct FCTTIMEStructure : Decodable {
    var hour_padded : String
}

struct TampStructure: Decodable {
    var metric : String
}
