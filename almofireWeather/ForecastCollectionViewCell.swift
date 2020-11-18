//
//  ForecastCollectionViewCell.swift
//  almofireWeather
//
//  Created by Ash on 24.09.2020.
//  Copyright © 2020 Ash. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var dayTempLabel: UILabel!
    @IBOutlet var nightTempLabel: UILabel!
    @IBOutlet var imageCondition: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   
    
    func dateFromNSDate(date: Double){
        let nsDate = NSDate(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.current.regionCode ?? "En") as Locale
        dateFormatter.dateFormat = "EEEE \n dd"
        let weekDay = dateFormatter.string(from: nsDate as Date)
        dataLabel.text = weekDay
    }
    
}
