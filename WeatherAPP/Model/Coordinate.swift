//
//  Coordinate.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//


import Foundation

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

extension Coordinate: Equatable {
    static func ==(A: Coordinate, B: Coordinate) -> Bool {
        return A.lat == B.lat && A.lon == B.lon
    }
}
