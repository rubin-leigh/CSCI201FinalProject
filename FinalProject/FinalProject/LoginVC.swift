//
//  LoginVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/17/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.tabBar.isHidden = true
        
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        
        self.email.delegate = self
        self.password.delegate = self
        self.hideKeyboardWhenBackgroundTapped()
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    @IBAction func createAnAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "loginToRegisterSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        self.login()
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Forgot password", message: "Enter your email address", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Email"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print((textField?.text)!)
            Auth.auth().sendPasswordReset(withEmail: (textField?.text)!) { (error) in
                if error != nil {
                    self.serveAlert(title: "Error", message: (error?.localizedDescription)!)
                }
                else {
                    self.serveAlert(title: "Success", message: "Password reset email sent")
                }
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func login() {
        let passwordActual = self.password.text
        
        if passwordActual != "" {
            self.view.isUserInteractionEnabled = false
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { user, error in
                // ideally should log the error message here
                self.view.isUserInteractionEnabled = true
                if error == nil {
                    if (Auth.auth().currentUser?.isEmailVerified)! {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "loginToNotVerifiedVC", sender: nil)
                    }
                }else {
                    self.serveAlert(title: "Error Logging In", message: error?.localizedDescription as String!)
                }
            })
        } else {
            self.serveAlert(title: "Password Needed", message: "Password is a required field")
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


extension UIViewController {
    func serveAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
