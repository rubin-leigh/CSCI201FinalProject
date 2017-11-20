//
//  EventTypeVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/14/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class EventTypeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let userActual = User.currentUser
    @IBOutlet weak var typePicker: UIPickerView!
    
    let types = ["Sport","Education","Philanthropy","Greek Life"]
    var type = "Sport"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.typePicker.delegate = self
        self.typePicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectRow(_ sender: Any) {
        userActual.currentEvent.type = type
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = types[row]
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
