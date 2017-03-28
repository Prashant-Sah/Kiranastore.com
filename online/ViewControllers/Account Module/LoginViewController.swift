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
    
    
    override func viewDidAppear(_ animated: Bool) {
        userNameTextField.text =  UserDefaults.standard.object(forKey: "checklogin1") as! String?
        passwordTextField.text = UserDefaults.standard.object(forKey: "checklogin2") as! String?
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //userNameTextField.text = "Pras"
        //passwordTextField.text = "pras"
        
    }
}

//MARK- button handler
extension LoginViewController {
    
    @IBAction func done_pressed(_ sender : UIButton) {
        
        if( userNameTextField.text != nil && passwordTextField.text != nil ) {
            
            if User.userDictionary.keys.contains(userNameTextField.text!) {
                
                if(User.userDictionary[userNameTextField.text!]! == passwordTextField.text!){
                    print("Pass match")
                    // MARK - work of NSNotification and defaults
                    Variables.isLoggedIn = true
                    //NotificationCenter.default.post(name: LOGINSUCCESFULLNOTIFICATION, object: self)
                    UserDefaults.standard.set(userNameTextField.text, forKey: "checklogin1")
                    UserDefaults.standard.set(passwordTextField.text, forKey: "checklogin2")
                    self.dismiss(animated: true, completion: nil)
                    
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    
                    if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                        appDelegate.window?.rootViewController = tabVC
                        appDelegate.window?.makeKeyAndVisible()
                    }
                }
                else {
                    let alertcontroller = UIAlertController(title: "Error", message: "Username or password didnot match", preferredStyle: UIAlertControllerStyle.alert)
                    alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                    self.present(alertcontroller, animated: true, completion: nil)
                }
            }
                
            else {
                let alertcontroller = UIAlertController(title: "Error", message: "You have not been registered yet!!", preferredStyle: UIAlertControllerStyle.alert)
                alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                self.present(alertcontroller, animated: true, completion: nil)
            }
        }
        else{
            let alertcontroller = UIAlertController(title: "Error", message: "Username or password fields empty." , preferredStyle: UIAlertControllerStyle.alert)
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

