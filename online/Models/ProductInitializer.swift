//
//  ProductInitializer.swift
//  online
//
//  Created by Prashant Sah on 3/9/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation
import UIKit

class ProductInitializer {
    
    var prodList = [Products]()
    
    static let prodShared = ProductInitializer()
    
    init()
    {
        initProducts()
    }
    
    func initProducts(){
        
        prodList.append(Products(withData: ["productName": "WaiWai" as AnyObject, "price" : 20 as AnyObject , "productImage" : UIImage(named : "download.jpg")!]))
        prodList.append(Products(withData: ["productName": "Wai" as AnyObject, "price" : 30 as AnyObject , "productImage" : UIImage(named : "download.jpg")!]))
        prodList.append(Products(withData: ["productName": "Mayos" as AnyObject, "price" : 40 as AnyObject , "productImage" : UIImage(named : "download.jpg")!]))

    
    }
    
    
}
