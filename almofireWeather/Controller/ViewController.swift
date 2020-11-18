//
//  ViewController.swift
//  almofireWeather
//
//  Created by Ash on 02.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, WeatherManagerDelegate {
    
    
    
    @IBOutlet var cityLable: UILabel!
    @IBOutlet var countryLable: UILabel!
    @IBOutlet var tempLable: UILabel!
    @IBOutlet var conditionLable: UILabel!
    @IBOutlet var iconOpenWeather: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var citytextField: UITextField!
    
   
    var weather: Weather? = nil
    var openWeather: WeatherForecast?
    var dailyWeather: [Daily]?
    var weatherManager = WeatherManager()

 var locationManager: CLLocationManager?
    var lat:Double = 0
    var lon:Double = 0
    
    var locationForDecode: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        
        
         let userSerchedLocation = UserDefaults.standard.value(forKey: "userSerchLocation")
        
        if userSerchedLocation != nil {
            LocationFromCityName(cityName: userSerchedLocation as! String)
        } else {
            startLocation()
        }
        
        
        self.collectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ForecastCollectionViewCell")
        self.collectionView.dataSource = self
        collectionView.backgroundColor = nil
        cityLable.adjustsFontSizeToFitWidth = true
        tempLable.adjustsFontSizeToFitWidth = true
//         startLocation()
//

    }
   
    
    func didUpdateWeather(weather: WeatherForecast) {
//      Set value for collectionView
        dailyWeather = weather.daily
        
        
        self.tempLable.text = weather.current.temp.dollarString + "℃"
        self.conditionLable.text = weather.current.weather[0].description
        self.iconOpenWeather.image = UIImage(systemName: weather.current.weather[0].conditionImage)
        
        
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
           
        print("HERE IS INFO! \(weather.current)")
        }
    }

    @IBAction func showCurrentLocation(_ sender: Any) {
        startLocation()
        citytextField.text = nil
        citytextField.placeholder = "Type city name"
        
    }
    
   
    
}

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        citytextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citytextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        LocationFromCityName(cityName: self.citytextField.text!)
        UserDefaults.standard.set(self.citytextField.text, forKey: "userSerchLocation")
//        getLocationFromCityName(cityName: self.citytextField.text!) { (coordination, error) in
//            guard let coordination = coordination, error == nil else {return}
//            self.weatherManager.fetchWeatherData(lat: coordination.latitude, lon: coordination.longitude)
//            self.showMapLocation(lat: coordination.latitude, lon: coordination.longitude)
//            self.getCityNameFromCoordinate(userLocation: CLLocation(latitude: coordination.latitude, longitude: coordination.longitude))
//            UserDefaults.standard.set(self.citytextField.text, forKey: "userSerchLocation")
//        }
    }
    
}



extension Double {
    var dollarString: String {
        return String(format: "%.1f", self)
    }
    var zeroAfterComma: String {
        return String(format: "%.0f", self)
    }
}

