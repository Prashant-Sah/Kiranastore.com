//
//  User.swift
//  online
//
//  Created by Prashant Sah on 3/6/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation
import CoreData

class User {
    
    var name : String?
    var contact : String?
    var username : String?
    var password : String?
    var emailAdd : String?
    
    static var userDictionary = [String:String]()
    
    init(withData: [String:AnyObject]) {
        
        self.name = withData["name"] as? String
        self.contact = withData["contact"] as? String
        self.username = withData["username"] as? String
        self.password = withData["password"] as? String
        
        print("name: \(name), password : \(password)")
        
        User.userDictionary[username!] = password
//        for  user in UserInitializer.userArray{
//            User.userDictionary[user.username!] = user.password
    
    }
    
}
