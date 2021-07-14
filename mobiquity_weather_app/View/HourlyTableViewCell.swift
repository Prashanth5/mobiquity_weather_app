//
//  HourlyTableViewCell.swift
//  mobiquity_weather_app
//
//  Created by Prashanth Parate on 10/07/21.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "HourlyTableViewCell"
    static func nib() -> UINib{
        return  UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    func configure(with model: CityForecast){
        
    }
}
