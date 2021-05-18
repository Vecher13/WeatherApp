//
//  LocationManager.swift
//  almofireWeather
//
//  Created by Ash on 13.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Alamofire


extension ViewController{
    
  
    func startLocation(){
        
 locationManager = CLLocationManager()
   
        locationManager = CLLocationManager()
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestAlwaysAuthorization()
         locationManager?.delegate = self
    if CLLocationManager.locationServicesEnabled(){
        locationManager?.startUpdatingLocation()
    }
}
    
    
    
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
//    let weatherManager = WeatherManager()
 let userLocation :CLLocation = locations[0] as CLLocation
    
    if let location = locations.last{
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
        
        self.lon = location.coordinate.longitude
        self.lat = location.coordinate.latitude
        
        
        self.weatherManager.fetchWeatherData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        self.getCityNameFromCoordinate(userLocation: userLocation)
        DispatchQueue.main.async {
            self.showMapLocation(lat: self.lat, lon: self.lon)
        }
       
    }



    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager?.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    
    
    }
    
   

    self.locationManager?.stopUpdatingLocation()
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    
    }
    
    

    
 }
    func showMapLocation(lat: Double, lon: Double) {
        let coordinate2d = CLLocationCoordinate2DMake(lat, lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: coordinate2d, span: span)
        self.mapView.setRegion(region, animated: true)
        
        
    }
    
    func getCityNameFromCoordinate(userLocation: CLLocation){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            guard let placemark = placemarks else {return}

            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality ?? "")
                print(placemark.administrativeArea!)
                print(placemark.country!)

                self.countryLable.text = "\(placemark.country ?? "Somewhere")"
                 self.cityLable.text = "\(placemark.locality ?? "I need more information!")"
                UserDefaults.standard.set(placemark.locality, forKey: "userSerchLocation")
                
            }
        }
    }
    
    func getLocationFromCityName(cityName: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(cityName) { completion($0?.first?.location?.coordinate, $1) }
        
    }
    
    func LocationFromCityName(cityName: String) {
        CLGeocoder().geocodeAddressString(cityName) { (coordinations, error) in
            guard let coordination = coordinations, error == nil else {return}
            let coordinate = coordination[0].location?.coordinate
            
            self.weatherManager.fetchWeatherData(lat: coordinate!.latitude, lon: coordinate!.longitude)
            self.showMapLocation(lat: coordinate!.latitude, lon: coordinate!.longitude)
            self.getCityNameFromCoordinate(userLocation: CLLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude))
           
        }
    }
    
    
}
