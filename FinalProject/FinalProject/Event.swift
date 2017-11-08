//
//  Event.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/7/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import Foundation
import GoogleMaps

class Event {
    var name:String
    var description:String
    var type:String
    var location:CLLocationCoordinate2D
    var marker:GMSMarker
    
    init(name:String,description:String,type:String,lattitude:Double,longitude:Double) {
        self.name = name
        self.description = description
        self.type = type
        self.location = CLLocationCoordinate2DMake(lattitude, longitude)
        
        self.marker = GMSMarker(position: self.location)
        self.marker.title = self.name
        self.marker.snippet = self.description
        switch self.type {
        case "Sport":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.orange)
        case "Education":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.blue)
        case "Philanthropy":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.green)
        case "Greek Life":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.black)
        default:
            self.marker.icon = GMSMarker.markerImage(with: UIColor.red)
        }
        self.marker.appearAnimation = GMSMarkerAnimation.pop
    }
    
}
