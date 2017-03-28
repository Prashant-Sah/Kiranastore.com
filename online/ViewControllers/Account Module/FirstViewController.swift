//
//  FirstViewController.swift
//  online
//
//  Created by Prashant Sah on 3/3/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialSetUp()
    }
}

//MARk: Helper Methods
extension FirstViewController {
    
    func initialSetUp() {
        
    }
}

//MARK: Button Click Methods
extension FirstViewController {
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            //            self.present(signUpVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(signUpVC, animated: true)
            
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            //            self.present(loginVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func skipPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            
            appDelegate.window?.rootViewController = tabVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
}



