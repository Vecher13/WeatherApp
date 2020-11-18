//
//  request.swift
//  almofireWeather
//
//  Created by Ash on 05.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import UIKit
import Alamofire

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherForecast)
}
struct WeatherManager{
    var delegate: WeatherManagerDelegate?
    func fetchWeatherData(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&lang=ru&appid=bb4e6de196fa29acec33e4c1fbd235b8") else {return}
        
        AF.request(url).validate().responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success( _):
                
                do {
                    let weather = try JSONDecoder().decode(WeatherForecast.self, from: dataResponse.data!)
                    self.delegate?.didUpdateWeather(weather: weather)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
}



