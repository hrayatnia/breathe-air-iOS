//
//  LocationManager.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

class LocationManager:NSObject, CLLocationManagerDelegate {
    static let shared: LocationManager = LocationManager()
    private let locationManager = CLLocationManager()
    let locationUpdated: PublishSubject<CLLocationCoordinate2D> = PublishSubject()
    private var lastLocation: CLLocationCoordinate2D? = nil {
        didSet {
            getPlace{
                data in
                self.country = data?.country
                self.city = data?.locality
            }
        }
    }
    var country: String? = nil
    var city: String? = nil
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
            return Location(uuid: "", deviceId: "", lat: 51, long: 31, date: Date())
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
        self.locationUpdated.onNext(locValue)
    }
    
    func getPlace(completion: @escaping (CLPlacemark?) -> Void) {
        guard let location = self.lastLocation else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    
}
