//
//  ViewController.swift
//  weather
//
//Users/aleksandrharcenko/Desktop/weather/weather/Controllers//  Created by Александр Харченко on 23.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit
import MapKit

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate, CanRecieveFavoriteCity {
   
    func receiveData(nameCity: String, lat: Double, lon: Double) {
        cityLabel.text = nameCity
        weatherData(lat: lat, lon: lon)
    }
    
    
    @IBAction func refreshButton(_ sender: Any) {
        self.locationMeneger.startUpdatingLocation()
    }
    
    @IBAction func showFavoriteCity(_ sender: Any) {

    }
    
    @IBAction func addCityToFavorite(_ sender: Any) {
     
        if latitude == nil {
            let currentLat = locationMeneger.location?.coordinate.latitude
            let currentLon = locationMeneger.location?.coordinate.longitude
            latitude = currentLat
            longitude = currentLon
            saveCity.addCityToFavorite(nameCity: cityLabel.text!, lat: latitude!, lon: longitude!)
            latitude = nil
        }else {
            saveCity.addCityToFavorite(nameCity: cityLabel.text!, lat: latitude!, lon: longitude!)
            latitude = nil
        }
        
    }
    @IBAction func searchCityButton(_ sender: Any) {
        latitude = nil
        longitude = nil
        let resultsViewController = GoogleHelper().autocompleteResultsViewController
        resultsViewController.delegate = self
        resultSearchController = UISearchController(searchResultsController: resultsViewController)
        resultSearchController?.searchResultsUpdater = resultsViewController
        resultSearchController?.searchBar.sizeToFit()
        definesPresentationContext = true
        SearchControllerHelper().searchView(resultSearchController!, resultsViewController: resultsViewController)
        SearchControllerHelper().filter(resultsViewController)
        present(resultSearchController!, animated: true, completion: nil)
    }
   
    
    @IBOutlet weak var hourDayCollectionView: UICollectionView!
    @IBOutlet weak var forecast10dayTableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var relative_humidity: UILabel!
    @IBOutlet weak var feelsLike_c: UILabel!
    @IBOutlet weak var wind_kph: UILabel!
    @IBOutlet weak var temperatureRange: UILabel!
    @IBOutlet weak var presentDay: UILabel!
    @IBOutlet weak var fctTextMetric: UILabel!
    
    
    let locationMeneger = CLLocationManager()
    var geocoder: CLGeocoder!
    var placemark: CLPlacemark!
    var resultSearchController: UISearchController?
    var resultView: UITextView?
    let saveCity = SaveCity(persistentManager: PersistentManager.shared)
    var latitude : Double?
    var longitude : Double?
    
    var hourDayArray = [Hourly_forecastSructure?]()
    var forecast10day = [ForecastdayStructure?]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        hourDayCollectionView.layer.cornerRadius = 10
        forecast10dayTableView.layer.cornerRadius = 15
        navigationItem.titleView = currentWeatherImage
        locationMeneger.delegate = self
        locationMeneger.desiredAccuracy = kCLLocationAccuracyBest
        locationMeneger.requestWhenInUseAuthorization()
        locationMeneger.startUpdatingLocation()
        mapView.layer.cornerRadius = mapView.frame.height / 2
        photoImageView.layer.cornerRadius = 12
        fctTextMetric.layer.cornerRadius = 12
        setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popoverView = segue.destination
        popoverView.view.backgroundColor = UIColor.clear
        popoverView.popoverPresentationController?.delegate = self
        let destinationVc = segue.destination as! FavoriteCityController
        destinationVc.delegate = self
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationHelper().locationManager(manager, didUpdateLocations: locations) { (region, city, country) in
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            self.cityLabel.text = city
            let lat = region.center.latitude
            let lon = region.center.longitude
            self.weatherData(lat: lat, lon: lon)
        }
    }
    
    func weatherData(lat: CLLocationDegrees, lon: CLLocationDegrees){
            GetJsonData().getCurrentWeather(lat: lat, lon: lon, completion: { (currentWeatherData) in
                GetJsonData().get10DayForcast(lat: lat, lon: lon, completion: { (forecast10Day) in
                    GetJsonData().getHourDayData(lat: lat, lon: lon, completion: { (hourDayData) in
                        let presentDay = forecast10Day.forecast?.txt_forecast.forecastday[0].title
                        let fcttext_metric = forecast10Day.forecast?.txt_forecast.forecastday[0].fcttext_metric
                        let highTemp = forecast10Day.forecast?.simpleforecast.forecastday[0].high.celsius
                        let lowTemp = forecast10Day.forecast?.simpleforecast.forecastday[0].low.celsius
                        
                        DispatchQueue.main.async {
                            self.fctTextMetric.text = fcttext_metric
                            self.presentDay.text = "\(String(describing: presentDay!))"
                            self.temperatureRange.text = "\(String(describing: highTemp!))°  \(String(describing: lowTemp!))°"
                            self.relative_humidity.text = "\(currentWeatherData.current_observation.relative_humidity)"
                            self.feelsLike_c.text = "\(currentWeatherData.current_observation.feelslike_c)°"
                            self.wind_kph.text = "\(currentWeatherData.current_observation.wind_kph)км/ч"
                            self.weatherLabel.text = currentWeatherData.current_observation.weather
                            self.currentTempLabel.text = "\(currentWeatherData.current_observation.temp_c)°"
                            self.currentWeatherImage.downloadImeg(from: currentWeatherData.current_observation.icon_url)
                            self.hourDayArray = hourDayData.hourly_forecast
                            self.forecast10day = (forecast10Day.forecast?.simpleforecast.forecastday)!
                            self.hourDayCollectionView.reloadData()
                            self.forecast10dayTableView.reloadData()
                        }
                    })
                })
            })
    }
}
