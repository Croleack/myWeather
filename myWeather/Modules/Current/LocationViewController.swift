//
//  ViewController.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class LocationViewController: UIViewController {
    
    private let mainView = CurrentWeatherView()
    //MARK: -  viewDidLoad()
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   LocationManager.shared.delegate = self
	   setupUI()
	   getLocation()
	   
    }
    //MARK: -  functions
    private func getLocation() {
	   LocationManager.shared.getCurrentLocation { [weak self] location in
		  guard let self = self else { return }
		  
		  WeatherManager.getWeather(latitude: location.coordinate.latitude,
							   longitude: location.coordinate.longitude) { result in
			 switch result {
			 case .success(let weatherDetail):
				
				let viewModelCurrent = CurrentWeatherCollectionViewCellViewModel(model: weatherDetail)
				
				var viewModelsDaily: [DailyWeatherCollectionViewCellViewModel] = []
				if let dailyWeatherData = weatherDetail.list {
				    var previousDay = ""
				    for weatherData in dailyWeatherData {
					   let day = self.getDay(from: weatherData.dtTxt)
					   
					   if day != previousDay {
						  let viewModel = DailyWeatherCollectionViewCellViewModel(model: weatherData)
						  viewModelsDaily.append(viewModel)
						  
						  previousDay = day
					   }
				    }
				}
				
				DispatchQueue.main.async {
				    self.mainView.configure(with: [
					   .current(viewModel: viewModelCurrent),
					   .daily(viewModels: viewModelsDaily)
				    ])
				}
			 case .failure(_):
				DispatchQueue.main.async {
				    self.showAlert(title: Constants.alertError,
							    message: Constants.alertMessage)
				}
			 }
			 
		  }
	   }
    }
    
    private func getDay(from dateString: String?) -> String {
	   guard let dateString = dateString else { return "" }
	   let dateFormatter = DateFormatter()
	   dateFormatter.dateFormat = Constants.dateFormatter
	   if let date = dateFormatter.date(from: dateString) {
		  let dateFormatter = DateFormatter()
		  dateFormatter.dateFormat = Constants.dateFormatterTwo
		  return dateFormatter.string(from: date)
	   }
	   return ""
    }
    
    private func setupUI() {
	   view.backgroundColor = .systemBackground
	   view.addSubview(mainView)
	   NSLayoutConstraint.activate([
		  mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		  mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
		  mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
		  mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
	   ])
    }
}
//MARK: -  extension shares location
extension LocationViewController: LocationPermissionDelegate {
    func locationPermissionDidChange(granted: Bool) {
	   if granted {
		  mainView.showLocationDeniedLabel(false)
		  getLocation()
	   } else {
		  mainView.showLocationDeniedLabel(true)
	   }
    }
}
//MARK: -  extension data retrieval error
extension LocationViewController {
    func showAlert(title: String, message: String) {
	   let alertController = UIAlertController(title: title,
									   message: message,
									   preferredStyle: .alert)
	   let okAction = UIAlertAction(title: Constants.alertTitle,
							  style: .default,
							  handler: nil)
	   alertController.addAction(okAction)
	   present(alertController, animated: true, completion: nil)
    }
}
//MARK: -  extension constants

fileprivate extension LocationViewController {
    enum Constants {
	   static let alertError = "Error"
	   static let alertMessage = "Failed to fetch weather data. Please check your internet connection and try again."
	   static let alertTitle = "OK"
	   static let dateFormatter = "yyyy-MM-dd HH:mm:ss"
	   static let dateFormatterTwo = "EEEE"
    }
}
