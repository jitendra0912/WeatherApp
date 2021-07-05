//
//  BaseURL.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import Foundation

//MARK: BaseURL
struct BaseURL {
    static let weatherURL = "https://api.openweathermap.org" 
    static let webURL = "https://weather.com/"
}

//MARK: BasePath
struct BasePath {
    static let list = "/data/2.5/weather"
    static let current = "/data/2.5/forecast"
}
