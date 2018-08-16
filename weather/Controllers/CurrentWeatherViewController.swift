//
//  ViewController.swift
//  weather
//
//  Created by Александр Харченко on 23.07.2018.
//  Copyright © 2018 Александр Харченко. All rights reserved.
//

import UIKit
import MapKit


class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {
   
    @IBAction func refreshButton(_ sender: Any) {
        self.locationMeneger.startUpdatingLocation()
    }
  
    @IBAction func searchCityButton(_ sender: Any) {
        var resultsViewController = GoogleHelper().resultsViewController
        resultsViewController = GoogleHelper().autocompleteResultsViewController
        resultsViewController?.delegate = self
        resultSearchController = UISearchController(searchResultsController: resultsViewController)
        resultSearchController?.searchResultsUpdater = resultsViewController
        resultSearchController?.searchBar.sizeToFit()
        definesPresentationContext = true
        let searchController = resultSearchController?.searchBar
        searchController?.placeholder =  "Enter city"
        searchController?.tintColor = .blue
        searchController?.backgroundColor = UIColor.clear
        resultsViewController?.tintColor = UIColor.blue
        resultsViewController?.tableCellBackgroundColor = UIColor.cyan
        resultsViewController?.tableCellSeparatorColor = UIColor.clear
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
    
    var hourDayArray = [Hourly_forecastSructure?]()
    var forecast10day = [ForecastdayStructure?]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        hourDayCollectionView.layer.cornerRadius = 10
        forecast10dayTableView.layer.cornerRadius = 15
        scrollView.layer.cornerRadius = 30
        navigationItem.titleView = currentWeatherImage
        self.locationMeneger.delegate = self
        self.locationMeneger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationMeneger.requestWhenInUseAuthorization()
        self.locationMeneger.startUpdatingLocation()
        mapView.layer.cornerRadius = mapView.frame.height / 2
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
    
    func weatherData(lat: CLLocationDegrees, lon: CLLocationDegrees) {
       
            GetJsonData().getCurrentWeather(lat: lat, lon: lon, completion: { (currentWeatherData) in
                GetJsonData().get10DayForcast(lat: lat, lon: lon, completion: { (forecast10Day) in
                    GetJsonData().getHourDayData(lat: lat, lon: lon, completion: { (hourDayData) in
                        let presentDay = forecast10Day.forecast?.txt_forecast.forecastday[0].title
                        let fcttext_metric = forecast10Day.forecast?.txt_forecast.forecastday[0].fcttext_metric
                        let highTemp = forecast10Day.forecast?.simpleforecast.forecastday[0].high.celsius
                        let lowTemp = forecast10Day.forecast?.simpleforecast.forecastday[0].low.celsius
                        
                        DispatchQueue.main.async {
                            self.fctTextMetric.text = fcttext_metric
                            self.presentDay.text = "Сегодня \(String(describing: presentDay!))"
                            self.temperatureRange.text = "\(String(describing: highTemp!))°   \(String(describing: lowTemp!))°"
                            self.relative_humidity.text = "\(currentWeatherData.current_observation.relative_humidity)%"
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
    
    func cityOnTheMapView(lat: CLLocationDegrees, lon: CLLocationDegrees){
        // approximation of annotation
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake((lat), (lon))
        let span = MKCoordinateSpanMake(0.15, 0.15)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.mapView.setRegion(region, animated: true)
    }
}




