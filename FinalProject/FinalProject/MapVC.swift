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
    
    
    var camera: GMSCameraPosition!
    var mapView: GMSMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var isLoggedOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.checkIfUserLoggedIn(completion: {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        })
        
        //self.view.isUserInteractionEnabled = true
        //self.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
        
        self.camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 10.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = self.mapView
        self.mapView.delegate = self
        
        if let tempLocValue = locManager.location?.coordinate {
            self.locValue = tempLocValue
            self.camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 10.0)
            self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        }
        else {
            self.camera = GMSCameraPosition.camera(withTarget: locValue, zoom: 10.0)
            self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        }
        
        self.testData(lattitude: self.locValue.latitude, longitude: self.locValue.longitude)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = self.userActual.events
        self.mapView.selectedMarker = nil
        if self.userActual.filters.capacity > 0 {
            for event in self.events {
                if self.userActual.filters[event.type]! {
                    event.marker.opacity = 1
                    event.marker.isTappable = true
                }
                else {
                    event.marker.opacity = 0
                    event.marker.isTappable = false
                }
            }
        }
    }
    
    func testData(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let e1:Event = Event(name: "Sport", description: "This is a sporting event", type: "Sport", lattitude: 34.083911675564, longitude: -118.224263201058, startDate: "", startTime: "", endDate: "", endTime: "", partCap: 0)
//        let e2:Event = Event(name: "Education", description: "This is an educational event", type: "Education", lattitude: 34.183911675564, longitude: -118.194263201058, startDate: "", startTime: "", endDate: "", endTime: "", partCap: 0)
//        self.userActual.events.append(e1)
//        self.userActual.events.append(e2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locValue = (locManager.location?.coordinate)!
    }
    
    func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
        self.mapView = mapView
        for event in self.userActual.events {
            event.marker.map = mapView
        }
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        //if(userActual.type == "club")
//        let marker = GMSMarker(position: coordinate)
//        marker.appearAnimation = GMSMarkerAnimation.pop;
//        marker.title = "Event"
//        coorToAddress(coordinate: coordinate, completion: { loc in
//            marker.snippet = loc
//        })
//        marker.map = mapView
        if userActual.type == "club" {
            self.locValue = coordinate
            self.performSegue(withIdentifier: "mapToNewEventSegue", sender: nil)
        }
    }
    
    func coorToAddress(coordinate: CLLocationCoordinate2D, completion: @escaping (String)->()) {
        let geocoder = CLGeocoder()
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        var returnMessage = ""
        geocoder.reverseGeocodeLocation(loc, completionHandler: {
            placemarks, error in
            if error == nil && (placemarks?.count)! > 0 {
                let placeMark = placemarks?.last
                if let nameLocal = placeMark?.name,
                    let subThoroughfareLocal = placeMark?.subThoroughfare,
                    let thoroughfareLocal = placeMark?.thoroughfare {
                    if nameLocal != "\(subThoroughfareLocal) \(thoroughfareLocal)" {
                        returnMessage = "\(nameLocal)\n\(subThoroughfareLocal) \(thoroughfareLocal)\n\(String(describing: placeMark?.locality)), \(String(describing: placeMark?.administrativeArea)) \(String(describing: placeMark?.postalCode))"
                    }
                    else {
                        returnMessage = "\(placeMark!.subThoroughfare!) \(placeMark!.thoroughfare!)\n\(placeMark!.locality!), \(placeMark!.administrativeArea!) \(placeMark!.postalCode!)"
                    }
                }
                completion(returnMessage)
                self.locManager.stopUpdatingLocation()
            }
        })
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //go to full event description window view controller
        for event in self.userActual.events {
            if event.marker == marker {
                userActual.currentEvent = event
                break
            }
        }
        self.performSegue(withIdentifier: "viewEventSegue", sender: nil)
    }
    
    func checkIfUserLoggedIn(completion: @escaping ()->()) {
        self.view.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()

        Auth.auth().addStateDidChangeListener {
            (_, userLocal) in
            if userLocal != nil {
                if !self.userActual.loginBeenCalled {
                    self.userActual.loginBeenCalled = true
                    
                    self.userActual.loadUserInfo(userID: (userLocal?.uid)!) {success in
                        self.events = self.userActual.events
                        self.mapView.selectedMarker = nil
                        if self.userActual.filters.capacity > 0 {
                            for event in self.events {
                                if self.userActual.filters[event.type]! {
                                    event.marker.opacity = 1
                                    event.marker.isTappable = true
                                }
                                else {
                                    event.marker.opacity = 0
                                    event.marker.isTappable = false
                                }
                            }
                        }
                    }
                    self.isLoggedOut = false
                    self.view.isUserInteractionEnabled = true
                    self.navigationController?.navigationBar.isUserInteractionEnabled = true
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
            self.testData(lattitude: self.locValue.latitude, longitude: self.locValue.longitude)
            for event in self.events {
                if self.userActual.filters[event.type]! {
                    let marker = GMSMarker(position: event.location)
                    marker.appearAnimation = GMSMarkerAnimation.pop
                    marker.title = event.name
                    marker.snippet = "\(event.description)\n\n"
                    coorToAddress(coordinate: event.location, completion: { loc in
                        marker.snippet = "\(event.description)\n\n\(loc)"
                    })
                    marker.icon = GMSMarker.markerImage(with: event.color)
                    marker.map = mapView
                }
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToNewEventSegue" {
            let destVC = segue.destination as! NewEventVC
            coorToAddress(coordinate: locValue, completion: { loc in
                destVC.address = loc
                destVC.addressTF.text = loc
                destVC.activityIndicator.stopAnimating()
                destVC.activityIndicator.isHidden = true
                destVC.view.isUserInteractionEnabled = true
            })
        }
        else if segue.identifier == "viewEventSegue" {
            let destVC = segue.destination as! ViewEventVC
            destVC.event = userActual.currentEvent
        }
    }

}
