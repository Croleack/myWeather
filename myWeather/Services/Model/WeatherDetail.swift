//
//  WeatherDetail.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 23.03.2024.
//

import Foundation

struct WeatherDetail: Codable {
    let city: City?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [WeatherData]?
}
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
}
struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct WeatherData: Codable {
    let dt: TimeInterval?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
	   case dt, main, weather, clouds, wind, visibility, pop, sys
	   case dtTxt = "dt_txt"
    }
}

struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
	   case temp, pressure, humidity
	   case feelsLike = "feels_like"
	   case tempMin = "temp_min"
	   case tempMax = "temp_max"
	   case seaLevel = "sea_level"
	   case grndLevel = "grnd_level"
	   case tempKf = "temp_kf"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct Sys: Codable {
    let pod: String?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
