//
//  Enum+CurrentCellType.swift
//  WeatherAPP
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

enum CurrentCellType: Int {
    case TimesCell = 0
    case DetailCell 
    case DaysCell 
}

extension CurrentCellType {
    var cellType: UITableViewCell.Type {
        switch self {
        case .DaysCell:
            return DaysTableViewCell.self
        case .DetailCell:
            return DetailTableViewCell.self
        case .TimesCell:
            return CurrentWeatherTimesTableViewCell.self
        }
    }
}
