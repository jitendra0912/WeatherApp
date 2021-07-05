//
//  DetailTableViewCell.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightDescriptionLabel: UILabel!
    
    var weatherDetailData: WeatherInfo? {
        didSet{
            guard let timezone = weatherDetailData?.sys else {
                return
            }

            leftDescriptionLabel.text = timezone.sunset.dateFromMilliseconds().getCountryTime(byTimeZone: timezone.sunset)
            rightDescriptionLabel.text = timezone.sunrise.dateFromMilliseconds().getCountryTime(byTimeZone: timezone.sunrise)
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        leftTitleLabel.text = "SUNRISE"
        rightTitleLabel.text = "SUNSET"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
