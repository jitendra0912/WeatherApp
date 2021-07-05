//
//  Extension+Date.swift
//  WeatherAPP
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import Foundation

//MARK: Extension+Date
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday 
    }
    
    func dayNumberOfWeek(time: Int) -> Int? {
        guard let timeZone = TimeZone(abbreviation: calcuateGMT(time: time)) else {
            return 0
        }
        return Calendar.current.dateComponents(in: timeZone, from: self).weekday
    }
    
    func calcuateGMT(time: Int) -> String {
        let timeZone = abs(time) / 3600
        let compare = time < 0 ? "-" : "+" 

        if timeZone < 10 {
            return "GMT\(compare)0\(timeZone)"
        } else {
            return "GMT\(compare)\(timeZone)"
        }
    }
    
    func getCountryTime(byTimeZone time: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: calcuateGMT(time: time))
        let defaultTimeZoneStr = formatter.string(from: self)
        return defaultTimeZoneStr
    }
    
   
    func dayWord() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func dayMonthly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    func hour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }

    func hourMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        return dateFormatter.string(from: self)
    }
}
