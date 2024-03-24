//
//  CityViewController.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class CityViewController: UIViewController {
    
    private let mainView = CityWeatherView()
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupUI()
    }
    //MARK: - functions
    private func setupUI() {
	   view.backgroundColor = .systemBackground
	   view.addSubview(mainView)
	   
	   NSLayoutConstraint.activate([
		  mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		  mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
		  mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
		  mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
	   ])
	   mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
	   let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
	   view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func hideKeyboard() {
	   mainView.cityTextField.resignFirstResponder()
    }
    
    @objc
    private func searchButtonTapped() {
	   guard var cityName = mainView.cityTextField.text else {
		  mainView.temperatureLabel.text = Constants.enterCityNameError
		  return
	   }
	   
	   cityName = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
	   
	   guard !cityName.isEmpty else {
		  mainView.temperatureLabel.text = Constants.enterCityNameError
		  return
	   }
	   
	   WeatherManager.getWeatherCity(cityName: cityName) { result in
		  switch result {
		  case .success(let weatherDetail):
			 DispatchQueue.main.async {
				if let temperature = weatherDetail.list?.first?.main?.temp {
				    let roundedTemperature = Int(temperature)
				    self.mainView.temperatureLabel.text = "\(Constants.currentTemperature) \(roundedTemperature) \(Constants.temperatureUnit)"
				} else {
				    self.mainView.temperatureLabel.text = Constants.temperatureNotAvailable
				}
			 }
		  case .failure(let error):
			 print("Failed to fetch weather data: \(error)")
			 DispatchQueue.main.async {
				self.mainView.temperatureLabel.text = Constants.checkCityNameError
			 }
		  }
	   }
    }
}
//MARK: -  extension constants
fileprivate extension CityViewController {
    struct Constants {
	   static let enterCityNameError = "Enter the name of the city"
	   static let currentTemperature = "Current temperature"
	   static let temperatureUnit = "ºC"
	   static let temperatureNotAvailable = "Current temperature not available"
	   static let checkCityNameError = "Is it written correctly?"
    }
}
