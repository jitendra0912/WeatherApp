//
//  WeatherInfo.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

struct WeatherInfo: Codable {
    let timezone, id: Int?
    let name: String?
    let coordinate: Coordinate?
 
    let elements: [WeatherElement]?
    let base: String?
    let mainValue: CurrentWeatherMainValue?
    let visibility: Int?
    let wind: WeatherWind?
    let clouds: WeatherClouds?
    let date: Int?
    let sys: CurrentWeatherSys?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case base, visibility, wind, clouds, sys, timezone, id, name
        case elements = "weather"
        case coordinate = "coord"
        case mainValue = "main"
        case date = "dt"
        case code = "cod"
    }
}

// MARK: Clouds
struct WeatherClouds: Codable {
    let all: Int
}
//
// MARK: Main
struct CurrentWeatherMainValue: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: Sys
struct CurrentWeatherSys: Codable {
   // let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: Weather
struct WeatherElement: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: Wind
struct WeatherWind: Codable {
    let speed: Double
    let deg: Int?
}

