//
//  ViewController.swift
//  GMapSwift
//
//  Created by app on 8/8/16.
//  Copyright © 2016 app. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
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
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            //revealViewController().rearViewRevealWidth = 150
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
        if(indicateLocation == nil) {
            if let location = locations.first {
                let camera = GMSCameraPosition(target: location.coordinate, zoom: 6.0, bearing: 0, viewingAngle: 0)
                mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
            
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                marker.title = "Hanoi"
                marker.snippet = "Vietnam"
                marker.map = mapView
            
            }
        } else {
            let latitude: Double = (indicateLocation?.latitude)!
            let longitude: Double = (indicateLocation?.longitude)!
            
            let location1 = CLLocation(latitude: latitude, longitude: longitude);
            
            let camera = GMSCameraPosition(target: location1.coordinate, zoom: 6.0, bearing: 0, viewingAngle: 0)
            mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location1.coordinate.latitude, longitude: location1.coordinate.longitude)
            marker.title = indicateLocation?.loc_name
            marker.snippet = indicateLocation?.loc_real_address
            marker.map = mapView
        }
        
        locationManager.stopUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
//    override func loadView() {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6.0)
//        mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
//        mapView.myLocationEnabled = true
//        view = mapView
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }

}

