//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/15/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

public struct TestEvent {
    let type: String
    let title: String
    let date: Date
    let time: Time
    let location: String
    let image: String
    let contact: String
    let host: String
    let description: String

    public init(event: [String:AnyObject]) {
        type = event["type"] as! String
        title = event["title"] as! String
        date = event["date"] as! Date
        time = event["time"] as! Time
        location = event["location"] as! String
        image = event["image"] as! String
        contact = event["contact"] as! String
        host = event["host"] as! String
        description = event["description"] as! String
    }
}

public struct Date {
    
}

public struct Time {
    
}

public struct Participant {
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let apiEndpoint: String = "http://localhost:8080/finalProject/test?username=leighrub&location=Los%20Angeles"
//        guard let url = URL(string: apiEndpoint) else {
//            print("Error: cannot create URL")
//            return false
//        }
//        let urlRequest = URLRequest(url: url)
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            // check for any errors
//            guard error == nil else {
//                print("error calling GET on /todos/1")
//                print(error!)
//                return
//            }
//            // make sure we got data
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
//            // parse the result as JSON, since that's what the API provides
//            do {
//                guard let dict = try JSONSerialization.jsonObject(with: responseData, options: [])
//                    as? [String: Any] else {
//                        print("error trying to convert data to JSON")
//                        return
//                }
//                // now we have the todo
//                // let's just print it to prove we can access it
//
//                // the todo object is a dictionary
//                // so we just access the title using the "title" key
//                // so check for a title and print it if we have one
//            } catch  {
//                print("error trying to convert data to JSON")
//                return
//            }
//        }
//        task.resume()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

