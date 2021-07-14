//
//  CityWeather.swift
//  mobiquity_weather_app
//
//  Created by Prashanth Parate on 10/07/21.
//
//   let cityWeather = try? newJSONDecoder().decode(CityWeather.self, from: jsonData)

import Foundation

// MARK: - CityWeather
struct CityWeather: Codable {
    let coord: Coord1
    let weather: [Weather1]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind1
    let clouds: Clouds1
    let dt: Int
    let sys: Sys1
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds1: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord1: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys1: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather1: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind1: Codable {
    let speed: Double
    let deg: Int
}

