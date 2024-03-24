//
//  CurrentWeatherViewModel.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 23.03.2024.
//

import Foundation

enum WeatherViewModel {
    case current(viewModel: CurrentWeatherCollectionViewCellViewModel)
    case daily(viewModels: [DailyWeatherCollectionViewCellViewModel])
}
