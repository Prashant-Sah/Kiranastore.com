//
//  ProductsOnWeb.swift
//  online
//
//  Created by Prashant Sah on 3/22/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import Foundation

class ProductsOnWeb {
    
    var price : Int!
    var productName : String!
    var productImageLink : String!
       
    init(ProductDict : Dictionary< String, AnyObject> )
    {
        if let  name = ProductDict["productName"] as? String
        {
            self.productName = name.capitalized
        }
        
        if let price = ProductDict["price"] as? Int{
            self.price = price
        }
        
        if let prodImageLink = ProductDict["productImageLink"] as? String{
            self.productImageLink = prodImageLink
        }
    }
}
