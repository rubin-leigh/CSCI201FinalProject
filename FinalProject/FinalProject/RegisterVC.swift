//
//  ViewController.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/15/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController, UITextFieldDelegate {
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var clubButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //self.tabBarController?.tabBar.isHidden = true
        
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        
        self.studentButton.layer.borderColor = UIColor.white.cgColor
        self.clubButton.layer.borderColor = UIColor.white.cgColor
        
        self.studentButton.layer.cornerRadius = 5.0
        self.clubButton.layer.cornerRadius = 5.0
        
        self.email.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
        self.hideKeyboardWhenBackgroundTapped()
    }

    @IBAction func studentButtonPressed(_ sender: Any) {
        self.studentButton.layer.backgroundColor = UIColor.white.cgColor
        self.clubButton.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    @IBAction func clubButtonPressed(_ sender: Any) {
        self.studentButton.layer.backgroundColor = UIColor.clear.cgColor
        self.clubButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if(!((email.text?.isUSCEmail())!)) {
            self.serveAlert(title: "Invalid E-mail", message: "Emails must end in \"@usc.edu\"")
        }
        else if(!((password.text?.isValidPassword())!)) {
            self.serveAlert(title: "Invalid Password", message: "A valid password is at least 8 characters and contains:\n- 1 Uppercase character\n- 1 Lowercase character\n- 1 Numeric character\n- 1 Special character");
        }
        else if(password.text != confirmPassword.text) {
            self.serveAlert(title: "Password Mismatch", message: "Passwords do not match, please try again")
        }
        else {
            self.createUserActual()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createUserActual() {
            self.view.isUserInteractionEnabled = false
            Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!, completion: { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { user, error in
                        if error == nil {
                            self.view.isUserInteractionEnabled = true
                            self.performSegue(withIdentifier: "registerToNotVerifiedSegue", sender: nil)
                            Auth.auth().currentUser?.updateEmail(to: self.email.text!) { (error) in
                                Auth.auth().currentUser?.sendEmailVerification() { (error) in
                                }
                            }
                        }
                    })
                } else {
                    self.view.isUserInteractionEnabled = true
                }
            })
        }
    }



extension CAGradientLayer {
    func setColorUSC() {
        let color1 = UIColor(red: 153/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor as CGColor
        let color2 = UIColor(red: 187/255.0, green: 100/255.0, blue: 26/255.0, alpha: 1.0).cgColor as CGColor
        let color3 = UIColor(red: 222/255.0, green: 201/255.0, blue: 53/255.0, alpha: 1.0).cgColor as CGColor
        colors = [color1, color2, color3]
        
        locations = [0.0, 0.5, 1.0]
    }
}

extension UIViewController {
    func hideKeyboardWhenBackgroundTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    func isUSCEmail() -> Bool {
        if(suffix(8) == "@usc.edu") {
            return true;
        }
        return false;
    }
    
    func isValidPassword() -> Bool {
        if(count < 8) {
            return false;
        }
        
        let caps:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower:String = caps.lowercased()
        let numbers:String = "1234567890"
        let specials:String = "!@#$%^&*(){}[]\\_-.,/?;:\"\'=+|"
        
        var hasCap:Bool = false
        var hasLower:Bool = false
        var hasNumber:Bool = false
        var hasSpecial:Bool = false
        
        for c in characters {
            if caps.contains(c) {
                hasCap = true
                continue
            }
            else if lower.contains(c) {
                hasLower = true
                continue
            }
            else if numbers.contains(c) {
                hasNumber = true
                continue
            }
            else if specials.contains(c) {
                hasSpecial = true
                continue
            }
        }
        
        if(hasCap && hasLower && hasNumber && hasSpecial) {
            return true
        }
        return false
    }
}
