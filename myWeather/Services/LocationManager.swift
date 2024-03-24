//
//  LocationManager.swift
//  myWeather
//
//  Created by Enzhe Gaysina on 22.03.2024.
//

import Foundation
import CoreLocation
///access to location
protocol LocationPermissionDelegate: AnyObject {
    func locationPermissionDidChange(granted: Bool)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationPermissionDelegate?
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    private var locationFetchCompletion: ((CLLocation) -> Void)?
    
    private var location: CLLocation? {
	   didSet {
		  guard let location else { return }
		  locationFetchCompletion?(location)
	   }
    }
    
    public func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
	   
	   self.locationFetchCompletion = completion
	   
	   manager.requestWhenInUseAuthorization()
	   manager.delegate = self
	   manager.startUpdatingLocation()
    }
    ///We make sure that the user has given the go-ahead to receive the location
    func checkLocationPermission() {
	   let status = CLLocationManager().authorizationStatus
	   var granted = false
	   
	   switch status {
	   case .authorizedAlways, .authorizedWhenInUse:
		  granted = true
	   default:
		  granted = false
	   }
	   
	   delegate?.locationPermissionDidChange(granted: granted)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
	   checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	   guard let location = locations.first else { return }
	   self.location = location
	   manager.stopUpdatingLocation()
    }
}
