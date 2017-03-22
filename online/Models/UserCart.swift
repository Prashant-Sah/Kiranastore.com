//
//  UserCart.swift
//  online
//
//  Created by Prashant Sah on 3/10/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation

class UserCart {
    
    var productName : String?
    var qty : Int?
    var rate : Int?
    static var sharedCart:UserCart = UserCart()
    
    var cartArray = [UserCart]()
    
    init() {
        
    }
    
    init( withData : [String : AnyObject]) {
        self.productName = withData["productName"] as? String
        self.qty = withData["qty"] as? Int
        self.rate = withData["rate"] as? Int
    }
    
}
