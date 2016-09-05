//
//  ViewController.swift
//  GMapSwift
//
//  Created by app on 8/8/16.
//  Copyright © 2016 app. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, SWRevealViewControllerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet var mapView: GMSMapView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var indicateLocation: Location? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        
        // Do any additional setup after loading the view, typically from a nib.
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6.0)
//        mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
//        mapView.myLocationEnabled = true
//        view = mapView
//        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Hanoi"
//        marker.snippet = "Vietnam"
//        marker.map = mapView
        self.revealViewController().delegate = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            //revealViewController().rearViewRevealWidth = 150
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
    }
    
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.allowScrollGesturesDuringRotateOrZoom = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let camera = GMSCameraPosition(target: location.coordinate, zoom: 6.0, bearing: 0, viewingAngle: 0)
            mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            marker.title = "Hanoi"
            marker.snippet = "Vietnam"
            marker.map = mapView
//            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        let latitude: Double = (indicateLocation?.latitude)!
//        let longitude: Double = (indicateLocation?.longitude)!
//        
//        newLocation = CLLocation(latitude: latitude, longitude: longitude);
        
        let camera = GMSCameraPosition(target: newLocation.coordinate, zoom: 6.0, bearing: 0, viewingAngle: 0)
        mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        marker.title = indicateLocation?.loc_name
        marker.snippet = indicateLocation?.loc_real_address
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
        if (position == FrontViewPosition.Right) {
            revealController.frontViewController.view.userInteractionEnabled = true;
        }
        else {
            revealController.frontViewController.view.userInteractionEnabled = false;
            revealController.frontViewController.view.userInteractionEnabled = true;
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    func loadInidicatedView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        if indicateLocation != nil {
            let camera = GMSCameraPosition.cameraWithLatitude((indicateLocation?.latitude)!, longitude: (indicateLocation?.longitude)!, zoom: 15.0)
            mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
            mapView.myLocationEnabled = true
            view = mapView
        
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (indicateLocation?.latitude)!, longitude: (indicateLocation?.longitude)!)
            marker.title = indicateLocation?.loc_name
            marker.snippet = indicateLocation?.loc_real_address
            marker.map = mapView
        }
    }

}

