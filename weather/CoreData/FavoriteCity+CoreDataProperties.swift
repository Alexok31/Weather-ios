//
//  FavoriteCity+CoreDataProperties.swift
//  weather
//
//  Created by Александр Харченко on 10/1/18.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCity> {
        return NSFetchRequest<FavoriteCity>(entityName: "FavoriteCity")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var nameCity: String

}
