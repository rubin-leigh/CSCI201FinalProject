//
//  NotVerifiedVC.swift
//  
//
//  Created by Leigh Rubin on 10/29/17.
//

import UIKit
import FirebaseAuth

class NotVerifiedVC: UIViewController {
    let gradientLayer = CAGradientLayer()
    let userActual = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.tabBar.isHidden = true

        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh(_ sender: Any) {
        if((Auth.auth().currentUser?.isEmailVerified)!) {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func resendEmail(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if((Auth.auth().currentUser?.isEmailVerified)!) {
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                self.serveAlert(title: "Sent Email", message: "Sent verification email to \(Auth.auth().currentUser?.email!)")
            }
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
