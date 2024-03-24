//
//  NetworkManager.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 23.03.2024.
//

import Foundation

final class WeatherManager: NSObject {
    
    //MARK: - fetchWeather(current Location)
    static func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherDetail, Error>) -> Void) {
	   let lat = latitude.description
	   let lon = longitude.description
	   
	   if let url = URL(string: "\(Con.baseURL)?lat=\(lat)&lon=\(lon)&units=metric&APPID=\(Con.apiKey)") {
		  URLSession.shared.dataTask(with: url) { data, response, error in
			 if let error = error {
				completion(.failure(error))
				return
			 }
			 
			 guard let data = data else {
				completion(.failure(WeatherAPIError.invalidData))
				return
			 }
			 
			 do {
				let weatherDetail = try JSONDecoder().decode(WeatherDetail.self, from: data)
				completion(.success(weatherDetail))
			 } catch {
				completion(.failure(error))
			 }
		  }.resume()
	   } else {
		  completion(.failure(WeatherAPIError.invalidURL))
	   }
    }
    //MARK: - fetchWeather(City)
    static func getWeatherCity(cityName: String, completion: @escaping (Result<WeatherDetail, Error>) -> Void) {
	   guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
		  completion(.failure(WeatherAPIError.invalidCityName))
		  return
	   }
	   
	   if let url = URL(string: "\(Con.baseURL)?q=\(encodedCityName)&units=metric&APPID=\(Con.apiKey)") {
		  URLSession.shared.dataTask(with: url) { data, response, error in
			 if let error = error {
				completion(.failure(error))
				return
			 }
			 
			 guard let data = data else {
				completion(.failure(WeatherAPIError.invalidData))
				return
			 }
			 
			 do {
				let weatherDetail = try JSONDecoder().decode(WeatherDetail.self, from: data)
				completion(.success(weatherDetail))
			 } catch {
				completion(.failure(error))
			 }
		  }.resume()
	   } else {
		  completion(.failure(WeatherAPIError.invalidURL))
	   }
    }
}
// MARK: - WeatherAPIError
enum WeatherAPIError: Error {
    case invalidURL
    case invalidData
    case invalidCityName
}

// MARK: - Constants
extension WeatherManager {
    enum Con {
	   static let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
	   static let apiKey = "53ea9de349fd1cdfdb97aa10726c6a33"
    }
}
