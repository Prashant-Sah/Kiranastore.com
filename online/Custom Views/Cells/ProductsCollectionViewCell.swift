//
//  ProductsCollectionViewCell.swift
//  online
//
//  Created by Prashant Sah on 3/8/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit

protocol ProductProtocol: class {
    func didAddToCart(cell: ProductsCollectionViewCell )
}

class ProductsCollectionViewCell: UICollectionViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var proImage: UIImageView!
    @IBOutlet weak var prodLabel: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var qtyPickerView: UIPickerView!
    
    var isAddedTocart = false
    var delegate: ProductProtocol?
    let qtyArr = [0,1,2,3,4,5]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        qtyPickerView.dataSource = self
        qtyPickerView.delegate = self
        layer.cornerRadius = 5.0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return qtyArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(qtyArr[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        Variables.selectedQty = qtyArr[row]
        
    }
    
    // products changed to productsOnWeb
    //        func configureProduct(product: Products) {
    //           self.prodLabel.text = product.productName
    //            self.proImage.image = product.productImage
    //            self.prodPrice.text  = "Rs.\(product.price!)"
    //            self.addToCartButton.isEnabled = !(Variables.isAddedToCart)
    //            if self.addToCartButton.isEnabled == false
    //            {
    //                self.addToCartButton.setTitle("Added To Cart", for: .normal)
    //            }
    //        }
    
    func configureProduct (product : ProductsOnWeb)
    {
        self.prodLabel.text = product.productName
        let url = URL(string: product.productImageLink)
        if let data = NSData(contentsOf: url!){
            self.proImage.image = UIImage(data: data as Data)
        }
        
        self.prodPrice.text  = "Rs.\(product.price!)"
        self.addToCartButton.isEnabled = !(Variables.isAddedToCart)
        if self.addToCartButton.isEnabled == false
        {
            self.addToCartButton.setTitle("Added To Cart", for: .normal)
            self.qtyPickerView.selectRow(Variables.selectedQty!, inComponent: 0, animated: true)
            Variables.selectedQty = 0
        }
        else{
            self.addToCartButton.setTitle("Add To Cart", for: .normal)
            self.qtyPickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        self.delegate?.didAddToCart(cell: self)
    }
    
}
