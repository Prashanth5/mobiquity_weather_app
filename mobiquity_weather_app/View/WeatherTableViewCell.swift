//
//  WeatherTableViewCell.swift
//  mobiquity_weather_app
//
//  Created by Prashanth Parate on 10/07/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "WeatherTableViewCell"
    static func nib() -> UINib{
        return  UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    func configure(with model: List){
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = "\(Int(model.main.tempMin))º"
        self.highTempLabel.text = "\(Int(model.main.tempMax))º"
        self.dayLabel.text = getDayFromDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.iconImageView.image = UIImage(named: "sun")
        //change the icon based on weather
    }
    func getDayFromDate(_ date: Date?)-> String{
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
