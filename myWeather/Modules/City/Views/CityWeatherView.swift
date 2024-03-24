//
//  CityWeatherView.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

final class CityWeatherView: UIView {
    
    let cityTextField: UITextField = {
	   let textField = UITextField()
	   textField.placeholder = Constants.cityPlaceholder
	   textField.translatesAutoresizingMaskIntoConstraints = false
	   return textField
    }()
    
    let searchButton: UIButton = {
	   let button = UIButton(type: .system)
	   button.setTitle(Constants.searchButtonTitle, for: .normal)
	   button.translatesAutoresizingMaskIntoConstraints = false
	   return button
    }()
    
    let temperatureLabel: UILabel = {
	   let label = UILabel()
	   label.textAlignment = .center
	   label.translatesAutoresizingMaskIntoConstraints = false
	   return label
    }()
    
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   translatesAutoresizingMaskIntoConstraints = false
	   addSubview(cityTextField)
	   addSubview(searchButton)
	   addSubview(temperatureLabel)
	   
	   addConstraint()
    }
    
    required init?(coder: NSCoder) {
	   fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraint() {
	   NSLayoutConstraint.activate([
		  cityTextField.topAnchor.constraint(equalTo: topAnchor,
									  constant: Constants.textFieldTopMargin),
		  cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
										 constant: Constants.textFieldLeadingMargin),
		  cityTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
										  constant: Constants.textFieldTrailingMargin),
		  cityTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
		  
		  searchButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor,
									 constant: Constants.buttonTopMargin),
		  searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
		  
		  temperatureLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor,
										constant: Constants.labelTopMargin),
		  temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
										    constant: Constants.labelLeadingMargin),
		  temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
											constant: Constants.labelTrailingMargin),
	   ])
    }
}
//MARK: -  extension constants
fileprivate extension CityWeatherView {
    struct Constants {
	   static let cityPlaceholder = "Enter the name of the city"
	   static let searchButtonTitle = "Search"
	   static let textFieldTopMargin: CGFloat = 20
	   static let textFieldLeadingMargin: CGFloat = 16
	   static let textFieldTrailingMargin: CGFloat = -16
	   static let textFieldHeight: CGFloat = 40
	   static let buttonTopMargin: CGFloat = 20
	   static let labelTopMargin: CGFloat = 20
	   static let labelLeadingMargin: CGFloat = 16
	   static let labelTrailingMargin: CGFloat = -16
    }
}
