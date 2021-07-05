//
//  TimesCollectionViewCell.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    func config(weather data: List) {
        if let weather = data.weather.first {
          //  image = weather.icon
            iconImageView.image = UIImage(named: weather.icon)
        }
     percentageLabel.text =   "\(data.main.humidity)%"
        hourLabel.text =  data.dt.dateFromMilliseconds().hour()
    descriptionLabel.text = "\(Int(data.main.temp))°"
       
    }
   
}
