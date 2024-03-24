//
//  SceneDelegate.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
	   guard let windowScene = (scene as? UIWindowScene) else { return }
	   let window = UIWindow(windowScene: windowScene)
	   window.rootViewController = TabViewController()
	   self.window = window
	   self.window?.makeKeyAndVisible()
    }
}

