//
//  AppDelegate.swift
//  weather
//
//  Created by Александр Харченко on 23.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyCTUrydPtcNAhZ9-FoKfQOydxn4oKUkZQ8")
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
       // self.saveContext()
    }
   
    
    
}

