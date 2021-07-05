//
//  Enum+WeatherList.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

enum WeatherListCellType: Int {    
    case City = 0
    case Setting
}

extension WeatherListCellType: CaseIterable {}
