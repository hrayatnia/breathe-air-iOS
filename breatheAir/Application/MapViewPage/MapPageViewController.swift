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
import DrawerKit

class MapPageViewController: UIViewController,DrawerCoordinating {
    var drawerDisplayController: DrawerDisplayController?
    
    
    @IBOutlet weak var mapView: MKMapView!
    private var vm: MapPageViewModel!
    private let disposeBag = DisposeBag()
    private var alert:UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initLoadingView()
        initVm()
        initMapView()
        addAnnotation()
        bindErrorMessage()
    }
    
    
    @IBAction func currentLocationAction(_ sender: Any) {
        doModalPresentation(passthrough: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoading()
        
    }
    
    
    private func initMapView() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
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
                self.hideLoading()
                
            })
            .disposed(by: disposeBag)
    }
    
    
    private func initLoadingView() {
        self.alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        
    }
    
    private func showLoading() {
        present(self.alert, animated: true, completion: nil)
    }
    
    private func hideLoading() {
        dismiss(animated: true, completion: nil)
    }
    
    private func bindErrorMessage() {
        self
            .vm
            .output
            .errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{
                data in
                self.view.makeToast(data)
                self.hideLoading()
            }).disposed(by: disposeBag)
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

