//
//  NewEventVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/7/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class NewEventVC: UIViewController {
    var address:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "Create Event"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
