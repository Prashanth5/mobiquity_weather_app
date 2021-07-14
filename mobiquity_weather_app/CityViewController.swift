//
//  CityViewController.swift
//  mobiquity_weather_app
//
//  Created by Prashanth Parate on 10/07/21.
//

import Foundation
import UIKit
import CoreLocation

class CityViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var tableView: UITableView!
    var currentLocation: CLLocation?
    var models = [List]()
    let locationManager = CLLocationManager()
    var apiService: APIService!
    var current: CityWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "City Weather"
        self.tableView.reloadData()
        setupLocation()
    }
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty ,currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        self.apiService = APIService()
        self.apiService.getCityForecastBasedOn(lat: lat, long: long){ (cityForecastList, error) in
            self.models.append(contentsOf: cityForecastList!)
            //            for cf in cityForecastList!{
            //                //                print("TempMax:\(cf.main.tempMax)")
            //                //                print("TempMin:\(cf.main.tempMin)")
            //                self.models.append(cf)
            //            }
            print("model count:\(self.models.count)")
        }
        //let entries = apiService.getCityWeatherBasedOn(lat: lat, long: long)
        //        self.models.append(entries)
        print("Long:\(long),lat:\(lat)")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            self.tableView.tableHeaderView = self.createTableHeader()
        }
        
        
    }
    func createTableHeader() -> UIView {
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        headerVIew.backgroundColor = UIColor.red//UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))
        
        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        locationLabel.text = "Current Location"
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        
        tempLabel.text = "\(currentWeather.main.temp)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.weather.description
        
        return headerVIew
    }
    
    
}

extension CityViewController: UITableViewDelegate{
    
}
extension CityViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            // 1 cell that is collectiontableviewcell
//            return 1
//        }
        // return models count
        return (self.models.count > 0) ? self.models.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
//                    cell.configure(with: hourlyModels)
//                    cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
//                    return cell
//                }
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        if(self.models.count > 0){
            cell.configure(with: self.models[indexPath.row])
        }else{
            self.tableView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
}
