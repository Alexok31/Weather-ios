//
//  File.swift
//  weather
//
//  Created by Александр Харченко on 09.08.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation

struct Forecast10dayStructure: Decodable {
    var forecast : ForecastStructure?
    var error : ErrorStructure?
}

struct ForecastStructure: Decodable  {
    var simpleforecast: SimpleforecastStructure
    var txt_forecast: Txt_forecastStructure
}

struct Txt_forecastStructure: Decodable {
    var forecastday: [ForecastPeriodStructure]
}

struct ForecastPeriodStructure: Decodable {
    var title : String?
    var fcttext_metric : String?
}
struct SimpleforecastStructure: Decodable {
    var forecastday: [ForecastdayStructure]
}

struct ForecastdayStructure: Decodable {
    var date : DateStructure
    var high : HighStructure
    var low : LowStructure
    var conditions : String
    var icon_url : String
    var icon : String
}

struct HighStructure: Decodable {
    var celsius : String
}

struct LowStructure: Decodable {
    var celsius : String
}

struct DateStructure: Decodable {
    var day: Double
    var year: Double
    var monthname: String
    var weekday_short: String
    var weekday: String
}

struct ErrorStructure: Decodable {
    var description: String
}

