//
//  ViewEventVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 11/16/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class ViewEventVC: UIViewController {
    let userActual = User.currentUser
    var event: Event!
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        
        titleLabel.text = event.name
        descriptionLabel.text = event.description
        timeLabel.text = "\(event.startDate) \(event.startTime) - \(event.endDate) \(event.endTime)"
        participantsLabel.text = "\(event.partTotal)/\(event.partCap)"
        typeLabel.text = event.type
        
        if event.partTotal >= event.partCap || userActual.type == "club" || userActual.type == "guest" {
            joinButton.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinEvent(_ sender: Any) {
        let partTotal = event.partTotal + 1
        event.partTotal = partTotal
        DispatchQueue.main.async {
            self.userActual.saveEventData(updatePackage: ["title":self.event.name,"partTotal":self.event.partTotal.description], completionHandler: { (success) in
                print("Joined event")
            })
            self.navigationController?.popViewController(animated: true)
        }
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
