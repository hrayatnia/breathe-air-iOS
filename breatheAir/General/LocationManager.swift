//
//  LocationManager.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager:NSObject, CLLocationManagerDelegate {
    static let shared: LocationManager = LocationManager()
    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocationCoordinate2D? = nil
    override init() {
        super.init()
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func currentLocationRequest() -> Location {
        if let location = self.lastLocation {
            return self.makeRequest(location)
        }else if let location = self.locationManager.location?.coordinate {
            return self.makeRequest(location)
        }else {
            fatalError("[ERROR -: can't fetch location]")
        }
    }
    
    private func makeRequest(_ data: CLLocationCoordinate2D) -> Location {
        return Location(uuid: UUID().uuidString,
                        deviceId: Device.vendorIdString,
                        lat: data.latitude,
                        long: data.longitude,
                        date: Date())
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.lastLocation = locValue
    }
}
