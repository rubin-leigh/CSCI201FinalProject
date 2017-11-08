//
//  User.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/29/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import Foundation
import Firebase

class User {
    static let currentUser = User()
    
    var firebaseUserID = ""
    var loggedOut:Bool = true
    
    var type: String = ""
    var filters: [String:Bool] = [:]
    
    var loginBeenCalled:Bool = false
    
    func loadUserInfo(userID:String, completionHandler: @escaping ((_ exist: Bool) -> Void)) {
        self.firebaseUserID = userID
        
        self.loggedOut = false
        
        Database.database().reference().child("users").child(self.firebaseUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = snapshot.childSnapshot(forPath: "User").value as? NSDictionary {
                if user["type"] != nil {
                    self.type = (user["type"] as? String)!
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
    
    func signOut() {
        self.firebaseUserID = ""
        self.loggedOut = true
        self.type = ""
        self.filters = [:]
        self.loginBeenCalled = false
        
        try! Auth.auth().signOut()
    }
}
