//
//  Hepler.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 04/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

class Hepler: NSObject {

    static let share = Hepler()
    private override init() {}
    
    func makeAttributed(originalTest:String, targetString:String)->NSMutableAttributedString {
        let color = UIColor.white;
        let textToFind = targetString
        let attrsString =  NSMutableAttributedString(string:originalTest);
        // search for word occurrence
        let range = (originalTest as NSString).range(of: textToFind)
        if (range.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor,value:color,range:range)
        }
        return attrsString
    }
    
}
