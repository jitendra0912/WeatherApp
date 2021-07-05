//
//  FiveDayWeather.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//


import Foundation

// MARK: FiveDayWeather
struct FiveDayWeather: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
    let city: City
    
    var dailyList: [List] {
        var result: [List] = []
        guard var before = list.first else {
            return result
        }
        
        if before.dt.dateFromMilliseconds().dayWord() != Date().dayWord() {
            result.append(before)
        }

        for weather in list {
            if weather.dt.dateFromMilliseconds().dayWord() != before.dt.dateFromMilliseconds().dayWord() {
                result.append(weather)
            }
            before = weather
        }

        return result
    }
}

// MARK: City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let timezone: Int
    var population: Int?
    let sunrise, sunset: Int
    enum CodingKeys: String, CodingKey {
        case id, name
        case coord = "coord"
        case country, timezone, sunrise, sunset
    }
}

// MARK: List
struct List: Codable {
    let dt: Int
    let main: FiveMain
    let weather: [FiveWeather]
    let clouds: WeatherClouds
    let wind: WeatherWind
    let sys: FiveSys
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: FiveMain
struct FiveMain: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let seaLevel: Double
    let grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: Rain
struct Rain: Codable {
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

// MARK: Sys
struct FiveSys: Codable {
    let pod: String
}

// MARK: FiveWeather
struct FiveWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

