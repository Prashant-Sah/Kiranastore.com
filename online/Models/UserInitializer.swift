//
//  UserInitializer.swift
//  online
//
//  Created by Prashant Sah on 3/8/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation

class UserInitializer{
    
    static let shared = UserInitializer()
    
    static var userArray = [User]()
    
    init() {
    
    UserInitializer.userArray.append(User(withData: [ "name" : "Prashant" as AnyObject , "contact" : "9741311676" as AnyObject,
    "username": "Pras" as AnyObject, "password": "pras" as AnyObject,
    "emailAdd": "pras@gmail.com" as AnyObject]))
    
    UserInitializer.userArray.append(User(withData: [ "name" : "Bishal " as AnyObject , "contact" : "9849507004" as AnyObject,
    "username": "Heuju" as AnyObject, "password": "heuju" as AnyObject,
    "emailAdd": "heuju@gmail.com" as AnyObject]))
    
    print(UserInitializer.userArray.count)
        
    }

}
