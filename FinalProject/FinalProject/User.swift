//
//  User.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/29/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User {
    static let currentUser = User()
    
    var firebaseUserID = ""
    var loggedOut:Bool = true
    
    var type: String = ""
    var filters: [String:Bool] = [:]
    var events: [Event] = []
    
    var currentEvent: Event!
    
    var loginBeenCalled:Bool = false
    
    func loadUserInfo(userID:String, completionHandler: @escaping ((_ exist: Bool) -> Void)) {
        self.firebaseUserID = userID
        
        self.loggedOut = false
        
        Database.database().reference().child("users").child(self.firebaseUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = snapshot.value as? [String:Any] {
                if user["type"] != nil {
                    self.type = (user["type"] as? String)!
                }
            }
        })
        
        Database.database().reference().child("events").observeSingleEvent(of: .value, with:
            { (snapshot) in
                if let eventDict = snapshot.value as? [String:[String:Any]] {
                    let keys = Array(eventDict.keys)
                    for key in keys {
                        if let e = eventDict[key] {
                            if let nameLocal = e["title"] as? String,
                                let descriptionLocal = e["description"] as? String,
                                let typeLocal = e["type"] as? String,
                                let latLocal = e["lat"] as? String,
                                let longLocal = e["long"] as? String,
                                let startDateLocal = e["startDate"] as? String,
                                let startTimeLocal = e["startTime"] as? String,
                                let endDateLocal = e["endDate"] as? String,
                                let endTimeLocal = e["endTime"] as? String,
                                let partCapLocal = e["partCap"] as? String,
                                let partTotalLocal = e["partTotal"] as? String
                            {
                                let event = Event(name: nameLocal, description: descriptionLocal, type: typeLocal, lattitude: Double(latLocal)!, longitude: Double(longLocal)!, startDate: startDateLocal, startTime: startTimeLocal, endDate: endDateLocal, endTime: endTimeLocal, partCap: Int(partCapLocal)!, partTotal: Int(partTotalLocal)!)
                                self.events.append(event)
                            }
                            
                        }
                    }
                }
        })
        
        
        self.filters = ["Sport":true,"Education":true,"Philanthropy":true,"Greek Life":true]
    }
    
    func saveUserData(updatePackage:[String:String], completionHandler: @escaping ((_ exist: Bool) -> Void)) {
        
        let localUpdatePackage = updatePackage
        
        
        // change "" values to nil
        var finalPacakge:[String:AnyObject?] = [:]
        
        for element in localUpdatePackage {
            if element.value == "" {
                let v : AnyObject? = nil
                finalPacakge[element.key] = v
            } else {
                finalPacakge[element.key] = element.value as AnyObject?
            }
        }
        
        
        let ref = Database.database().reference()
        
        ref.child("users").child(self.firebaseUserID).updateChildValues(finalPacakge as Any as? [AnyHashable : Any] ?? ["dud":"dud"]) { (error, ref) -> Void in
            completionHandler(true)
        }
    }
    
    func saveEventData(updatePackage:[String:String], completionHandler: @escaping ((_ exist: Bool) -> Void)) {
        
        let localUpdatePackage = updatePackage
        
        // change "" values to nil
        var finalPacakge:[String:AnyObject?] = [:]
        
        for element in localUpdatePackage {
            if element.value == "" {
                let v : AnyObject? = nil
                finalPacakge[element.key] = v
            } else {
                finalPacakge[element.key] = element.value as AnyObject?
            }
        }
        
        
        let ref = Database.database().reference()
        
        ref.child("events").child(localUpdatePackage["title"]!).updateChildValues(finalPacakge as Any as? [AnyHashable : Any] ?? ["dud":"dud"]) { (error, ref) -> Void in
            completionHandler(true)
        }
    }
    
    func signOut() {
        self.firebaseUserID = ""
        self.loggedOut = true
        self.type = ""
        self.filters = [:]
        self.events = []
        self.loginBeenCalled = false
        try! Auth.auth().signOut()
    }
}
