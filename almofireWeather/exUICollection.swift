//
//  exUICollection.swift
//  almofireWeather
//
//  Created by Ash on 24.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import UIKit
import Foundation


extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.dailyWeather ?? "nothing")
        return self.dailyWeather?.count ?? 7
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
        let dailyForecast = self.dailyWeather?[indexPath.row] ?? nil
       
        cell.dateFromNSDate(date: dailyForecast?.dt ?? 0)
//        cell.dataLabel.text =  "\(dailyForecast?.dt ?? 0)"
        cell.descriptionLabel.text = dailyForecast?.weather[indexPath.section].description ?? ""
        cell.dayTempLabel.text = dailyForecast?.temp.day.zeroAfterComma
        cell.nightTempLabel.text = dailyForecast?.temp.night.zeroAfterComma
        cell.imageCondition.image = UIImage(systemName: dailyForecast?.weather[indexPath.section].conditionImage ?? "cloud")
        
        
        return cell
        
    }
    
    
    
    
    
}
