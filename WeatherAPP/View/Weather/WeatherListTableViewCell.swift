//
//  WeatherListTableViewCell.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {


    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var weatherData: WeatherInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Timer.scheduledTimer(timeInterval: 60,
                             target: self, 
                             selector: #selector(updateTime),
                             userInfo: nil,
                             repeats: true
        )
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func updateTime() {
        guard let timezone = weatherData?.timezone else {
            return
        }
        timeLabel.text = Date().getCountryTime(byTimeZone: timezone)
    }
    
    func config(weatherInfoData: WeatherInfo, fahrenheitOrCelsius: FahrenheitOrCelsius) {
        weatherData = weatherInfoData
        updateTime()
        cityNameLabel.text = weatherInfoData.name
        switch fahrenheitOrCelsius {
        case .Celsius:
            temperatureLabel.text = (weatherInfoData.mainValue?.temp.makeCelsius() ?? "") +
                fahrenheitOrCelsius.emoji
        case .Fahrenheit:
            temperatureLabel.text = (weatherInfoData.mainValue?.temp.makeFahrenheit() ?? "") +
                fahrenheitOrCelsius.emoji
        }
    }
}
