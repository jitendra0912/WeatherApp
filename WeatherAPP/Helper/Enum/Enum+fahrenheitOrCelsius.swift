//
//  Enum+FahrenheitOrCelsius.swift
//  WeatherAPP
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import Foundation

enum FahrenheitOrCelsius: String {
    case Fahrenheit
    case Celsius 
}

extension FahrenheitOrCelsius {
    var stringValue: String {
        return "\(self)"
    }
    
    var emoji: String {
        switch self {
        case .Celsius:
            return "℃"
        case .Fahrenheit:
            return "℉"
        }
    }
}
