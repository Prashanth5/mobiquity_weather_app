//
//  APIService.swift
//  mobiquity_weather_app
//
//  Created by Prashanth Parate on 09/07/21.
//

import Foundation

class APIService: NSObject{
    var resultCityWeather: CityWeather!
    
    func getCityWeatherBasedOn(lat: Double,long:Double) -> CityWeather{
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=7777881f600df42de0aaaaa512f009e2"
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            guard let data = data,error == nil else{
                print("something went wrong..")
                return
            }
            var json: CityWeather?
            do{
                json = try JSONDecoder().decode(CityWeather.self, from: data)
            }catch{
                print("Error:\(error)")
            }
            guard let result = json else{
                return
            }
            print(result.weather[0].weatherDescription)
            print(result.name)
            self.resultCityWeather = result
        }.resume()
        return self.resultCityWeather
    }
    func getCityForecastBasedOn(lat: Double,long:Double, completion: @escaping([List]?, Error?) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=7777881f600df42de0aaaaa512f009e2"
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            guard let data = data,error == nil else{
                print("something went wrong..")
                return
            }
            var resultCityForecast = [List]()
            var json: CityForecast?
            do{
                json = try JSONDecoder().decode(CityForecast.self, from: data)
                
                for cityForecast in json!.list{
                    resultCityForecast.append(
                        List(dt: cityForecast.dt , main: cityForecast.main, clouds: cityForecast.clouds, wind: cityForecast.wind, visibility: cityForecast.visibility, pop: cityForecast.pop, rain: cityForecast.rain, sys: cityForecast.sys, dtTxt: cityForecast.dtTxt)
                    )
                }
            }catch{
                print("Error:\(error)")
            }
            guard let result = json else{
                return
            }
            
            completion(resultCityForecast,nil)
            print(result.city)
            print(result.message)
        }.resume()
    }
}
