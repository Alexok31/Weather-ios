//
//  hourDayJson.swift
//  weather
//
//  Created by Александр Харченко on 23.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation

class GetJsonData {
    let apiKey = "AIzaSyAfCXFvz1Lcqxu6Lj0RxhwldsODUlHB8GU"
    
    
    func getHourDayData(lat: Double, lon: Double, completion: @escaping ((HourDayStructure) -> ())) {
            let hourUrl = "http://api.wunderground.com/api/7529e02c052c477b/hourly/lang:RU/q/\(lat),\(lon).json"
            guard let urlId = URL(string: hourUrl) else {return}
            URLSession.shared.dataTask(with: urlId) { (data, response, error) in
                guard let data = data else {return}
                guard error == nil else {return}
                do {
                    let jsonHourDay = try JSONDecoder().decode(HourDayStructure.self, from: data)
                    completion(jsonHourDay)
                } catch let error {
                    print(error)
                }
                } .resume()
    }
    
    func get10DayForcast(lat: Double, lon: Double, completion: @escaping ((Forecast10dayStructure) -> ())){
        let urlString = "http://api.wunderground.com/api/7529e02c052c477b/forecast10day/lang:RU/q/\(lat),\(lon).json"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let jsonCityWeather = try JSONDecoder().decode(Forecast10dayStructure.self, from: data)
                completion(jsonCityWeather)
            } catch let error {
                print(error)
                
            }
            } .resume()
        }
    
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping ((CurrentTempStructure) -> ())) {
        let currentUrl = "http://api.wunderground.com/api/7529e02c052c477b/conditions/lang:RU/q/\(lat),\(lon).json"
        guard let urlId = URL(string: currentUrl) else {return}
        URLSession.shared.dataTask(with: urlId) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let jsonCurrentWeather = try JSONDecoder().decode(CurrentTempStructure.self, from: data)
                completion(jsonCurrentWeather)
            } catch let error {
                print(error)
            }
            } .resume()
        
    }
}
