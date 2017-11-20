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
    var startDate:String
    var startTime:String
    var endDate:String
    var endTime:String
    var partCap:Int
    var partTotal:Int
    var color:UIColor
    var marker:GMSMarker
    
    init(name:String,description:String,type:String,lattitude:Double,longitude:Double,startDate:String,startTime:String,endDate:String,endTime:String,partCap:Int,partTotal:Int) {
        self.name = name
        self.description = description
        self.type = type
        self.location = CLLocationCoordinate2DMake(lattitude, longitude)
        self.startDate = startDate
        self.startTime = startTime
        self.endDate = endDate
        self.endTime = endTime
        self.partCap = partCap
        self.partTotal = partTotal
        
        self.marker = GMSMarker(position: self.location)
        self.marker.appearAnimation = GMSMarkerAnimation.pop
        self.marker.title = self.name
        self.marker.snippet = self.description
        switch self.type {
        case "Sport":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.orange)
            self.color = UIColor.orange
        case "Education":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.blue)
            self.color = UIColor.blue
        case "Philanthropy":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.green)
            self.color = UIColor.green
        case "Greek Life":
            self.marker.icon = GMSMarker.markerImage(with: UIColor.black)
            self.color = UIColor.black
        default:
            self.marker.icon = GMSMarker.markerImage(with: UIColor.red)
            self.color = UIColor.red
        }
    }
    
}
