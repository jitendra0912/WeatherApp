//
//  Extension+Double.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import Foundation

//MARK: Extension+Double
extension Double {
    // kelvin to celsius
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    // kelvin to fahrenheit
    func makeFahrenheit() -> String {
        let argue = (self * 9/5) - 459.67
        return String(format: "%.0f", arguments: [argue])
    }
    
    // rounding double to 2 decimal place
    func makeRound() -> Double {
        return (self * 100).rounded() / 100
    }
}
extension Int {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    func timeConversion24(time12: String) -> String {
        let dateAsString = time12
            let df = DateFormatter()
            df.dateFormat = "h:mm:a"
            let date = df.date(from: dateAsString)
            df.dateFormat = "h:mm:a"
            let time24 = df.string(from: date!)
            return time24
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func timeConversion24(time12: String) -> String {
        let dateAsString = time12
            let df = DateFormatter()
            df.dateFormat = "hh:mm:ssa"

            let date = df.date(from: dateAsString)
            df.dateFormat = "HH:mm:ss"
            let time24 = df.string(from: date!)
            return time24
    }
}
