//
//  saveCity.swift
//  weather
//
//  Created by Александр Харченко on 10/1/18.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import Foundation

class SaveCity {
    
    let persistentManager : PersistentManager
    
    init(persistentManager: PersistentManager) {
        self.persistentManager = persistentManager
    }
    
    // Create Core Data Object
    
    func addCityToFavorite(nameCity: String, lat: Double, lon: Double) {
        let favoriteCity = FavoriteCity(context: persistentManager.context)
        favoriteCity.nameCity = nameCity
        favoriteCity.lat = lat
        favoriteCity.lon = lon
        
        persistentManager.save()
    }
    
    func fetchCity(completion: @escaping (([FavoriteCity]) -> ())) {
        guard let favoriteCitys = try! persistentManager.context.fetch(FavoriteCity.fetchRequest()) as? [FavoriteCity] else {return}
        completion(favoriteCitys)
    }
    
}
