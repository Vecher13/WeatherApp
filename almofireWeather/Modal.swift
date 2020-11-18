//
//  Modal.swift
//  almofireWeather
//
//  Created by Ash on 06.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let location: Location
    let currentObservation: CurrentObserbation
    let forecasts: [Forecaste]
}

struct Location: Decodable {
    let city: String
    let region: String
    let country: String
}
struct CurrentObserbation: Decodable {
    let astronomy: Astronomy
    let condition: Condition
    
}

struct Forecaste: Decodable {
    let day: String
    let date: Double
    let low: Int
    let high: Int
    let text: String
    let code: Int
    
}

struct Astronomy: Decodable {
    let sunrise: String
    let sunset: String
}

struct Condition: Decodable {
    let text: String
    let code: Int
    let temperature: Int
}


struct WeatherForecast: Decodable {
    let current: Current
    let hourly: [Current]
    let daily: [Daily]
    
    
    
    enum CodingKeys: String, CodingKey {
        case current = "current"
        case hourly = "hourly"
        case daily = "daily"
    }
    
    init(dictWeather: [String : Any]) {
        current = dictWeather["current"] as! Current
        hourly = dictWeather["hourly"] as! [Current]
        daily = dictWeather["daily"] as! [Daily]
    }
   
}

struct Current: Decodable {
    let dt: Double
    let sunrise: Double?
    let sunset: Double?
    let temp: Double
    let feels_like: Double
    let weather: [WeatherOpen]
}

struct Daily: Decodable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Temp
    let feels_like: FeelsLike
    let weather: [WeatherOpen]
}

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Decodable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherOpen: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    var conditionImage: String {
        switch icon {
        case "01d":
            return "sun.max"
        case "01n":
            return "moon.stars"
        case "02d":
            return "cloud.sun"
        case "02n" :
            return "cloud.moon"
        case "03d", "03n":
            return "cloud"
        case "04d", "04n":
        return "smoke"
        case "09d", "09n":
            return "cloud.drizzle"
        case "10d":
            return "cloud.sun.rain"
        case "10n":
            return "cloud.moon.rain"
        case "11d", "11n":
        return "cloud.bolt"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog"
        default:
            return "sparkles"
        }
    }
}
