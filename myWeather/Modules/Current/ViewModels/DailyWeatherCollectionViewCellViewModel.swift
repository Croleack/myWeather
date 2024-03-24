//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 23.03.2024.
//

import Foundation

struct DailyWeatherCollectionViewCellViewModel {
    private let model: WeatherData
    
    init(model: WeatherData) {
	   self.model = model
    }
    
    public var temperature: String {
	   let maxTemp = Int(model.main?.tempMax ?? -100.0)
	   return "Max \(maxTemp)ºC"
    }
    public var temperatureMin: String {
	   let minTemp = Int(model.main?.tempMin ?? -100.0)
	   return "Min \(minTemp)ºC"
    }
    
    public var day: String {
	   if let dateString = model.dtTxt {
		  let dateFormatter = DateFormatter()
		  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		  if let date = dateFormatter.date(from: dateString) {
			 let dateFormatter = DateFormatter()
			 dateFormatter.dateFormat = "EEEE"
			 return dateFormatter.string(from: date)
		  }
	   }
	   return "-"
    }
}
