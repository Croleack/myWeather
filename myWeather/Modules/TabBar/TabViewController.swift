//
//  TabViewController.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//
import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupTab()
    }
    
    private func setupTab() {
	   
	   tabBar.barStyle = Constants.tabBarStyle
	   tabBar.barTintColor = Constants.tabBarTintColor
	   
	   let tabLocation = LocationViewController()
	   tabLocation.title = Constants.locationTitle
	   let tabCity = CityViewController()
	   tabCity.title = Constants.cityTitle
	   let tabSettings = SettingsViewController()
	   tabSettings.title = Constants.settingsTitle
	   
	   let navigationCity = UINavigationController(rootViewController: tabLocation)
	   let navigationCoordinate = UINavigationController(rootViewController: tabCity)
	   let navigationSettings = UINavigationController(rootViewController: tabSettings)
	   
	   navigationCity.tabBarItem = UITabBarItem(title: Constants.locationTabTitle,
									    image: Constants.locationTabImage,
									    tag: Constants.locationTabTag)
	   navigationCoordinate.tabBarItem = UITabBarItem(title: Constants.cityTabTitle,
											image: Constants.cityTabImage,
											tag: Constants.cityTabTag)
	   navigationSettings.tabBarItem = UITabBarItem(title: Constants.settingsTabTitle,
										   image: Constants.settingsTabImage,
										   tag: Constants.settingsTabTag)
	   
	   setViewControllers([
		  navigationCity,
		  navigationCoordinate,
		  navigationSettings,
	   ], animated: true)
    }
}
//MARK: -  extension constants
fileprivate extension TabViewController {
    enum Constants {
	   static let tabBarStyle: UIBarStyle = .black
	   static let tabBarTintColor: UIColor = .gray
	   static let locationTitle = "Weather outside the window"
	   static let cityTitle = "Temperature by city"
	   static let settingsTitle = "Settings"
	   static let locationTabTitle = "Location"
	   static let cityTabTitle = "Cities"
	   static let settingsTabTitle = "Settings"
	   static let locationTabImage = UIImage(systemName: "location")
	   static let cityTabImage = UIImage(systemName: "cloud.moon.fill")
	   static let settingsTabImage = UIImage(systemName: "gear")
	   static let locationTabTag = 1
	   static let cityTabTag = 2
	   static let settingsTabTag = 3
    }
}
