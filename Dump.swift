//
//  Dump.swift
//  almofireWeather
//
//  Created by Ash on 17.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import Foundation


//func fetchData(lat: Float, lon: Float){
//        print(lat, lon)
////       let testLat = 37.330147
////        let testLon = -122.03167
//        let url = "https://weather-ydn-yql.media.yahoo.com/forecastrss?format=json&u=c&lat=\(lat)&lon=\(lon)"
//        print(url)
//        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
//        request.addValue("OAuth oauth_consumer_key=\"dj0yJmk9MEl6WWtoMDNTMjZaJnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTkx\",oauth_signature_method=\"HMAC-SHA1\",oauth_consumer_secret=\"b426952622f91ead96576322c7f4c5db51343b0b\",oauth_nonce=\"IQeImvDBnPa\",oauth_version=\"1.0\",oauth_signature=\"9yucEq%2BgLz2uh4uesjQAD2cbcaA%3D\"", forHTTPHeaderField: "Authorization")
//
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//          guard let data = data else {
//            print(String(describing: error))
//            return }
//            do {
//                let decode = JSONDecoder()
//                decode.keyDecodingStrategy = .convertFromSnakeCase
//                self.weather = try decode.decode(Weather.self, from: data)
//                DispatchQueue.main.async {
////                    self.setValueForCurrentWeather(for: self.weather)
//                }
//
//                print(self.weather!)
//                print(self.changeDayName(incominData: self.weather!))
//            } catch let error {
//         print(error)
//            }
//        }.resume()
//    }
