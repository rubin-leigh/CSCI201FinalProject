//
//  LoginVC.swift
//  FinalProject
//
//  Created by Leigh Rubin on 10/17/17.
//  Copyright © 2017 Leigh Rubin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.setColorUSC()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
        
        self.email.delegate = self
        self.password.delegate = self
        self.hideKeyboardWhenBackgroundTapped()
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
        
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
