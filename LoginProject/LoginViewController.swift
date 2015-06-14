//
//  LoginViewController.swift
//  LoginProject
//
//  Created by Nicholas Markworth on 6/14/15.
//  Copyright (c) 2015 Nick Markworth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, CreateAccountViewControllerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Creating a tap gesture recognizer in order to dismiss the keyboard when the main view is touched
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedView")
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Gesture handlers
    // Dismiss keyboard if main view is touched
    func tappedView() {
        for view in self.view.subviews {
            if view.isKindOfClass(UITextField) {
                view.resignFirstResponder()
            }
        }
    }
    
    // Dismiss keyboard if Return button is pressed on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loginToCreateAccountSegue" {
            var createAccountVC = segue.destinationViewController as! CreateAccountViewController
            createAccountVC.delegate = self
        }
    }
    
    // If the user already has an account, bypass account creation
    func accountCreated() {
        self.performSegueWithIdentifier("loginToMainSegue", sender: nil)
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        // Access the username and password from when the account was created
        let userNameSavedFromNSUserDefaults = NSUserDefaults.standardUserDefaults().objectForKey(kUserNameKey) as? String
        println(userNameSavedFromNSUserDefaults)
        let passwordSavedFromNSUserDefaults = NSUserDefaults.standardUserDefaults().objectForKey(kPasswordKey) as? String
        println(passwordSavedFromNSUserDefaults)
        
        // Make sure the saved username and password match what the user entered
        if usernameTextField.text == userNameSavedFromNSUserDefaults && passwordTextField.text == passwordSavedFromNSUserDefaults {
            self.performSegueWithIdentifier("loginToMainSegue", sender: self)
        }
        else {
            Alert.showAlertWithText(viewController: self, header: "Login Error", message: "Your username and/or password are incorrect.")
        }
    }
    
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("loginToCreateAccountSegue", sender: self)
    }
}
