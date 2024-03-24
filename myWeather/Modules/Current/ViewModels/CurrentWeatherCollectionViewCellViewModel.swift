//
//  CurrentWeatherCollectionViewCellViewModel.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 23.03.2024.
//

import Foundation

struct CurrentWeatherCollectionViewCellViewModel {
    private let model: WeatherDetail
    
    init(model: WeatherDetail) {
	   self.model = model
    }
    
    public var city: String {
	   return model.city?.name ?? "Hell"
    }
    
    public var temp: Int {
	   return Int(model.list?.first?.main?.temp ?? -100.0)
    }
    
    public var tempMin: Int {
	   return Int(model.list?.first?.main?.tempMin ?? -100.0)
    }
    
    public var tempMax: Int {
	   return Int(model.list?.first?.main?.tempMax ?? -100.0)
    }
    
    public var desc: String? {
	   guard let weather = model.list?.first?.weather?.first else {
		  return nil
	   }
	   return weather.description ?? "something broke, we are already working on it"
    }
    
    public var wind: Int? {
	   guard let firstWeatherData = model.list?.first else {
		  return nil 
	   }
	   return Int(firstWeatherData.wind?.speed ?? -100.00)
    }
}
