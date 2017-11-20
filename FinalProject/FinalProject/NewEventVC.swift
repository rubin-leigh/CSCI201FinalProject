//
//  NewEventVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/7/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit
import GooglePlaces

class NewEventVC: UIViewController, UISearchBarDelegate {
    var address:String = ""
    let gradientLayer = CAGradientLayer()
    
    let userActual = User.currentUser
    
    var currentEvent: Event!

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var startTimeTF: UITextField!
    @IBOutlet weak var endTimeTF: UITextField!
    @IBOutlet weak var partCapSwitch: UISwitch!
    @IBOutlet weak var partCapTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addressField: UITextField!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partCapTF.keyboardType = UIKeyboardType.decimalPad
        partCapSwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        view.isUserInteractionEnabled = false
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.delegate = self
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.placeholder = "Address"
        searchController?.searchBar.isHidden = true
        searchController?.hidesNavigationBarDuringPresentation = false
        
        startTimeTF.adjustsFontSizeToFitWidth = true
        startTimeTF.minimumFontSize = 0.5
        endTimeTF.adjustsFontSizeToFitWidth = true
        endTimeTF.minimumFontSize = 0.5
        
        startTimeTF.placeholder = "Start Time"
        endTimeTF.placeholder = "End Time"
        
        userActual.currentEvent = Event(name: "", description: "", type: "", lattitude: 0.0, longitude: 0.0, startDate:"", startTime:"", endDate: "", endTime: "", partCap: 0, partTotal: 0)
        currentEvent = userActual.currentEvent
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startTimeTF.text = "\(self.userActual.currentEvent.startDate) \(self.userActual.currentEvent.startTime)"
        self.endTimeTF.text = "\(self.userActual.currentEvent.endDate) \(self.userActual.currentEvent.endTime)"
        self.typeTF.text = self.userActual.currentEvent.type
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        view.endEditing(true)
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        if value {
            partCapTF.isEnabled = true
            partCapTF.isHidden = false
        }
        else {
            partCapTF.isEnabled = false
            partCapTF.isHidden = true
        }
        // Do something
    }
    
    @IBAction func addressButton(_ sender: Any) {
        searchController?.isActive = true
        searchController?.searchBar.isHidden = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController?.searchBar.text = ""
        searchController?.searchBar.isHidden = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController?.searchBar.text = ""
        searchController?.searchBar.isHidden = true
    }
    
    @IBAction func createEvent(_ sender: Any) {
        if let nameLocal = titleTF.text,
            let descriptionLocal = descriptionTF.text,
            let typeLocal = typeTF.text,
            let addressLocal = addressTF.text,
            var partCapLocal = partCapTF.text
            {
                let startDateLocal = userActual.currentEvent.startDate
                let startTimeLocal = userActual.currentEvent.startTime
                let endDateLocal = userActual.currentEvent.endDate
                let endTimeLocal = userActual.currentEvent.endTime
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(addressLocal) { (placemarks, error) in
                    let location = placemarks?[0].location
                    
                    
                    let latLocal = location?.coordinate.latitude.advanced(by: 0).toString()
                    let longLocal = location?.coordinate.longitude.advanced(by: 0).toString()

                    if startTimeLocal == "" || endTimeLocal == "" || nameLocal == "" || descriptionLocal == "" || addressLocal == ""{
                        return
                    }
                    
                    if self.partCapSwitch.isOn && partCapLocal == "" {
                        return
                    }
                    else if !self.partCapSwitch.isOn {
                        partCapLocal = "0"
                    }
                    
                    
                    let updatePackage =  ["type":typeLocal,"title":nameLocal,"startDate":startDateLocal,"startTime":startTimeLocal,"endDate":endDateLocal,"endTime":endTimeLocal,"lat":latLocal,"long":longLocal,"host":self.userActual.firebaseUserID,"description":descriptionLocal,"partCap":partCapLocal,"partTotal":"0"] as! [String : String]
                    
                    let event = Event(name: nameLocal, description: descriptionLocal, type: typeLocal, lattitude: (location?.coordinate.latitude.advanced(by: 0))!, longitude: (location?.coordinate.longitude.advanced(by: 0))!, startDate: startDateLocal, startTime: startTimeLocal, endDate: endDateLocal, endTime: endTimeLocal, partCap: Int(partCapLocal)!, partTotal: 0)
                    
                    self.userActual.events.append(event)
                    
                    
                    self.userActual.events.append(self.currentEvent)
                    DispatchQueue.main.async {
                        self.userActual.saveEventData(updatePackage: updatePackage) { completion in
                            print("updated events data")
                        }
                    }
                    self.navigationController?.popViewController(animated: true)
                    
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endTimeSegue" {
            let destVC = segue.destination as! DatePickerVC
            destVC.isStartDate = false
        }
    }


}


extension NewEventVC: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        address = place.formattedAddress!
        addressTF.text = address
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.10f",self)
    }
}
