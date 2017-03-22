//
//  LoginViewController.swift
//  online
//
//  Created by Prashant Sah on 3/6/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var notAMember: UILabel!
    @IBOutlet weak var registerNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.text = "Pras"
        passwordTextField.text = "pras"
        
    }
    
    
}

//MARK- button handler
extension LoginViewController {
    
    @IBAction func done_pressed(_ sender : UIButton) {
        if( userNameTextField.text != nil && passwordTextField.text != nil )
        {
            print(User.userDictionary)
            
            for _ in UserInitializer.userArray {
                if(User.userDictionary[userNameTextField.text!]! == passwordTextField.text!) {
                    print("Pass match")
                    Variables.isLoggedIn = true
//                    let defaults = UserDefaults.standard
//                    defaults.set(userNameTextField.text, forKey: Variables.loggedinUser!)
                    self.dismiss(animated: true, completion: nil)
                    
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    
                    if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                        appDelegate.window?.rootViewController = tabVC
                        appDelegate.window?.makeKeyAndVisible()
                        
                    }
                    else{
                        //error handler
                    }
                    
                }
                else
                {
                    print("failed bhayo")
                }
            }
        }
            
        else{
            
            let alertcontroller = UIAlertController(title: "Error", message: "Username or password didnot match", preferredStyle: UIAlertControllerStyle.alert)
            alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
    @IBAction func register_pressed(_ sender: UIButton) {
        
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        let navVC = UINavigationController(rootViewController: signUpVC!)
        self.present(navVC, animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        
        let alertcontroller = UIAlertController(title: "Password Recovery", message: "A reset password has been sent to your email Address. Please check!!", preferredStyle: UIAlertControllerStyle.alert)
        alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alertcontroller, animated: true, completion: nil)
        
    }
    
}

extension LoginViewController : UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}

