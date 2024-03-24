//
//  SettingsViewViewModel.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import Foundation

struct SettingsViewViewModel {
    let options: [SettingOption]
}

enum SettingOption: CaseIterable {
    case measurementSystem
    case notifications
    case topic
    case problem
    
    var title: String {
	   switch self {
	   case .measurementSystem:
		  return "Measuring system"
	   case .notifications:
		  return "Notifications"
	   case .topic:
		  return "Change the topic"
	   case .problem:
		  return "Report a problem"
	   }
    }
}
