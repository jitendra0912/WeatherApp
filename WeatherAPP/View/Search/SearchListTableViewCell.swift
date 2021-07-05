//
//  SearchListTableViewCell.swift
//  WeatherAPP
//
//  Created by Jitendra Agarwal on 03/07/2021.
//  Copyright © 2021 Jitendra Agarwal. All rights reserved.
//

import UIKit
import MapKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    var searchData: MKLocalSearchCompletion? {
        didSet {
            guard let city = searchData else {
                return 
            }
            cityNameLabel.attributedText = highlightedText(city.title,
                                                           inRanges: city.titleHighlightRanges,
                                                           size: 17.0
            )
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    private func highlightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString? {
        let attributeText = NSMutableAttributedString(string: text)
        if let bold = UIFont(name: "AppleSDGothicNeo-Bold", size: size) {
            for value in ranges {
                attributeText.addAttribute(NSAttributedString.Key.font, 
                                           value: bold,
                                           range: value.rangeValue
                )
            }
            return attributeText
        }
        return nil
    }
    
    func config(data: MKLocalSearchCompletion) {
        searchData = data
    }
}
