//
//  DatePickerVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/13/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {
    let userActual = User.currentUser
    @IBOutlet weak var datePicker: UIDatePicker!
    var isStartDate: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        let strTime = timeFormatter.string(from: datePicker.date)
        
        if isStartDate {
            userActual.currentEvent.startDate = strDate
            userActual.currentEvent.startTime = strTime
        }
        else {
            userActual.currentEvent.endDate = strDate
            userActual.currentEvent.endTime = strTime
        }
        
        self.navigationController?.popViewController(animated: true)
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
