//
//  SettingsViewController.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let mainView: SettingsView = {
	   let view = SettingsView()
	   let viewModel = SettingsViewViewModel(options: SettingOption.allCases)
	   view.configure(with: viewModel)
	   return view
    }()
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   view.backgroundColor = .systemBackground
	   
	   mainView.delegate = self
	   setupUI()
	   
    }
    
    private func setupUI() {
	   view.addSubview(mainView)
	   NSLayoutConstraint.activate([
		  mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		  mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
		  mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
		  mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
	   ])
    }
    
}

extension SettingsViewController: SettingsViewDelegate {
    func settingsView(_ settingsView: SettingsView, didTap option: SettingOption) {
	   switch option {
	   case .measurementSystem:
		  toggleAppearanceMode()
	   case .notifications:
		  break
	   case .topic:
		  break
	   case .problem:
		  break
	   }
    }
    ///enable dark mode if necessary
    private func toggleAppearanceMode() {
	   if #available(iOS 13.0, *) {
		  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			 return
		  }
		  let appearance = windowScene.windows.first?.traitCollection.userInterfaceStyle
		  let newAppearance: UIUserInterfaceStyle = appearance == .dark ? .light : .dark
		  UserDefaults.standard.set(newAppearance.rawValue, forKey: "appAppearance")
		  windowScene.windows.first?.overrideUserInterfaceStyle = newAppearance
	   }
    }
}
