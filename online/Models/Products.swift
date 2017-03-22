//
//  Products.swift
//  online
//
//  Created by Prashant Sah on 3/8/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation
import UIKit

class Products {
    
    var productName: String?
    var price : Int?
    var productImage : UIImage?
    
    init(){
        
    }
    
    init(withData: [String:AnyObject]) {
        
        self.productName = withData["productName"] as? String
        self.price = withData["price"] as? Int
        self.productImage = (withData["productImage"] as? UIImage)!
        
    }
}
