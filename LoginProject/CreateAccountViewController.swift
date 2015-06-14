//
//  CreateAccountViewController.swift
//  LoginProject
//
//  Created by Nicholas Markworth on 6/14/15.
//  Copyright (c) 2015 Nick Markworth. All rights reserved.
//

import UIKit

// Build a custom protocol for use within our LoginViewController
protocol CreateAccountViewControllerDelegate {
    func accountCreated()
}

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var delegate: CreateAccountViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedView")
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // Save the username and password to NSUserDefaults
    @IBAction func createAccountButtonPressed(sender: UIButton) {
        if !usernameTextField.text.isEmpty && !passwordTextField.text.isEmpty && passwordTextField.text == confirmPasswordTextField.text {
            NSUserDefaults.standardUserDefaults().setObject(self.usernameTextField.text, forKey: kUserNameKey)
            NSUserDefaults.standardUserDefaults().setObject(self.passwordTextField.text, forKey: kPasswordKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
            
            delegate?.accountCreated()
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
