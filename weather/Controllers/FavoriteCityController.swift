//
//  FavoriteCityController.swift
//  weather
//
//  Created by Александр Харченко on 10/1/18.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit

class FavoriteCityController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cityTableView: UITableView!
    let saveCity = SaveCity(persistentManager: PersistentManager.shared)
    var favoriteCitys = [FavoriteCity?]()
    var delegate : CanRecieveFavoriteCity?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveCity.fetchCity { (city) in
            self.favoriteCitys = city
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! FavoriteCityCell
        let favotireCity = favoriteCitys.reversed()[indexPath.row]
        let nameCity = favotireCity?.nameCity
        let lat = favotireCity?.lat
        let lon = favotireCity?.lon
        GetJsonData().getCurrentWeather(lat: lat!, lon: lon!) { (curentWeatherData) in
            DispatchQueue.main.async {
                cell.weatherIcon.downloadImeg(from:  curentWeatherData.current_observation.icon_url)
                cell.tempCity.text = "\(Int(curentWeatherData.current_observation.temp_c))°"
            }
        }
        cell.nameCity.text = nameCity
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favotireCity = favoriteCitys.reversed()[indexPath.row]
        let nameCity = favotireCity?.nameCity
        let lat = favotireCity?.lat
        let lon = favotireCity?.lon
        delegate?.receiveData(nameCity: nameCity!, lat: lat!, lon: lon!)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = saveCity.persistentManager.context
        if editingStyle == .delete {
            let favotireCity = favoriteCitys.reversed()[indexPath.row]
            context.delete(favotireCity!)
            saveCity.persistentManager.save()
            do {
                favoriteCitys = try context.fetch(FavoriteCity.fetchRequest())
            }
            catch {
                print("error")
            }
            tableView.reloadData()
            
        }
        
    }
    override var preferredContentSize: CGSize {
        get {
            self.cityTableView.contentSize = CGSize(width: 200, height: favoriteCitys.count * 44)
            return self.cityTableView.contentSize
        }
        set {}
    }
}
