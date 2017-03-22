//
//  SignUpViewController.swift
//  online
//
//  Created by Prashant Sah on 3/6/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit
import SRFormValidator

class SignUpViewController: UIViewController {
    
    //Text Fields
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var contactTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var reenterPasswordTxtField: UITextField!
    @IBOutlet weak var emailAddTxtField: UITextField!
    
    //let nuser = User()
    
    //Error Labels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        func dismissIt(sender : UIBarButtonItem) {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: Selector(("dismissIt")))
        
        //default data
        nameTxtField.text = "Pankaj"
        contactTxtField.text = "98234024"
        usernameTxtField.text = "punkazz"
        passwordTxtField.text = "apple"
        reenterPasswordTxtField.text = "apple"
        emailAddTxtField.text = "pankaj@shah.com"
        
        
    }
    
    
}

//MARK- Button ≈Ωclick methods
extension SignUpViewController {
    
    @IBAction func done_pressed(_ sender: UIButton) {
        
        if(passwordTxtField.text != reenterPasswordTxtField.text)
        {
            let alertcontroller = UIAlertController(title: "Error", message: "Reentered Password did not match", preferredStyle: UIAlertControllerStyle.alert)
            alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alertcontroller, animated: true, completion: nil)
        }
        
        UserInitializer.userArray.append(User(withData: [ "name" : nameTxtField.text as AnyObject, "contact" : contactTxtField.text as AnyObject,
                                                          "username": usernameTxtField.text as AnyObject, "password": passwordTxtField.text as AnyObject,
                                                          "emailAdd": emailAddTxtField.text as AnyObject]))
        
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let navVC = UINavigationController(rootViewController: loginVC)
            self.present(navVC, animated: true, completion: nil)
            
            
            
        }
    }
}


//MARK: UITextField Methods
extension SignUpViewController : UITextFieldDelegate {
    
    
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
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y <= -30 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

