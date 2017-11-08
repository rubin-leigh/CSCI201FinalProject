//
//  MapVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/29/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    let userActual = User.currentUser
    var locManager = CLLocationManager()
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(34.0224, -118.2851)
    var events: [Event] = []
    
    var isLoggedOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkIfUserLoggedIn()
        
        //self.view.isUserInteractionEnabled = true
        //self.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
        
        if let tempLocValue = locManager.location?.coordinate {
            locValue = tempLocValue
            let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            mapView.delegate = self
        }
        else {
            let camera = GMSCameraPosition.camera(withTarget: locValue, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            mapView.delegate = self
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locValue = (locManager.location?.coordinate)!
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        //if(userActual.type == "club")
        let marker = GMSMarker(position: coordinate)
        marker.appearAnimation = GMSMarkerAnimation.pop;
        marker.title = "Event"
        coorToAddress(coordinate: coordinate, completion: { loc in
            marker.snippet = loc
        })
        marker.map = mapView
        
    }
    
    func coorToAddress(coordinate: CLLocationCoordinate2D, completion: @escaping (String)->()) {
        let geocoder = CLGeocoder()
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        var returnMessage = ""
        geocoder.reverseGeocodeLocation(loc, completionHandler: {
            placemarks, error in
            if error == nil && (placemarks?.count)! > 0 {
                let placeMark = placemarks?.last
                returnMessage = "\(placeMark!.name!)\n\(placeMark!.subThoroughfare!) \(placeMark!.thoroughfare!)\n\(placeMark!.locality!), \(placeMark!.administrativeArea!) \(placeMark!.postalCode!)"
                completion(returnMessage)
                self.locManager.stopUpdatingLocation()
            }
        })
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //go to full event description window view controller
    }
    
    func checkIfUserLoggedIn() {
        self.view.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false

        Auth.auth().addStateDidChangeListener {
            (_, userLocal) in
            if userLocal != nil {
                if !self.userActual.loginBeenCalled {
                    self.userActual.loginBeenCalled = true
                    
                    self.userActual.loadUserInfo(userID: (userLocal?.uid)!) {success in
                        //self.serveAlert(title: "Done", message: "Done loading")
                    }
                    self.view.isUserInteractionEnabled = true
                    self.navigationController?.navigationBar.isUserInteractionEnabled = true
                    self.isLoggedOut = false
                }
            }
            else {
                if !self.isLoggedOut {
                    // new user send to login
                    self.isLoggedOut = true
                    self.performSegue(withIdentifier: "mapToLoginSegue", sender: nil)
                }
                self.view.isUserInteractionEnabled = true
                self.navigationController?.navigationBar.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.isLoggedOut = true
        self.userActual.signOut()
        self.view.isUserInteractionEnabled = true
        self.performSegue(withIdentifier: "mapToLoginSegue", sender: nil)
    }
    
    func reloadMap() {
        if let tempLocValue = locManager.location?.coordinate {
            locValue = tempLocValue
            let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            mapView.delegate = self
            
            for event in events {
                if self.userActual.filters[event.type]! {
                    event.marker.map = mapView
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
