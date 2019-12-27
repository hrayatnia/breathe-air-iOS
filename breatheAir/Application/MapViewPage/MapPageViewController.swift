//
//  MapPageViewController.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapPageViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private var vm: MapPageViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initVm()
        initMapView()
        addAnnotation()
        
    }
    
    private func initMapView() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            self.mapView.showsUserLocation = true
            self.mapView.userTrackingMode = .follow
        } else {
            _ = LocationManager.shared.currentLocationRequest()
        }
        self.mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func initVm() {
        self.vm = MapPageViewModel(input: MapPageInput())
    }
    
    private func addAnnotation() {
        self
            .vm
            .output
            .annotations
            .asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {data in
                self.mapView.removeAnnotations([])
                self.mapView.addAnnotations(data)
            })
            .disposed(by: disposeBag)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MapPageViewController: MKMapViewDelegate {



  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! Artwork
    let launchOptions = [MKLaunchOptionsDirectionsModeKey:
      MKLaunchOptionsDirectionsModeDriving]
    // change presentable view
  }

}

