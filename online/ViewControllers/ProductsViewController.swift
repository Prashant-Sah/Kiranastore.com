//
//  ProductsViewController.swift
//  online
//
//  Created by Prashant Sah on 3/9/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    
    var cartItem: UserCart = UserCart()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Variables.isLoggedIn {
            loginBarButton.isEnabled = false
            loginBarButton.tintColor = UIColor.clear
        }
        
        let nibName = UINib(nibName: "ProductsCollectionViewCell", bundle: nil)
        self.myCollectionView.register(nibName, forCellWithReuseIdentifier: "ProdCell")
        
        let url: String = "http://localhost/products/products.php"
        let urlRequest = URL(string: url)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            ( data , response ,error ) in
            if(error != nil)
            {
                print(error.debugDescription)
            }
            else{
                do
                {
                    let obtainedData = try! JSONSerialization.jsonObject(with: data!, options: [] )
                    print(obtainedData)
                    
                }
            }
        }).resume()
    }
}

// MARK - Bar Button handlers
extension ProductsViewController{
    
    
    
    @IBAction func loginPressed(_ sender: UIBarButtonItem) {
        
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    
    
    
    
}

//extension UIViewController  {
//
//    func showAlert(message: String = "Sample message", ok: () -> (), cancel: () -> ()) {
//
//        let alertcontroller = UIAlertController(title: "Login Required", message: "Press Login to Continue", preferredStyle: UIAlertControllerStyle.alert)
//        alertcontroller.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
//            ok in
//            ok()
//        }))
//
//        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
//            cancel in
//            cancel()
//
//        }))
//        self.present(alertcontroller, animated: true, completion: nil)
//
//    }
//
//
//}



// MARK- Collection view setup
extension ProductsViewController : UICollectionViewDelegate, UICollectionViewDataSource, ProductProtocol {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductInitializer.prodShared.prodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "ProdCell", for: indexPath) as? ProductsCollectionViewCell
        cell?.configureProduct(product: ProductInitializer.prodShared.prodList[indexPath.row])
        cell?.delegate = self
        return cell!
        
    }
    
    func didAddToCart(cell: ProductsCollectionViewCell) {
        
        //self.showAlert(message: "Do you want to add this to cart?", ok
        //            }
        //        }, cancel: {
        //        })
        
        //if  Variables.
        if Variables.isLoggedIn == false
        {
            let alertcontroller = UIAlertController(title: "Login Required", message: "Press Signin button to continue", preferredStyle: UIAlertControllerStyle.alert)
            let alertaction1 = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alertaction2 = UIAlertAction(title: "Canel", style: .cancel, handler: nil)
            alertcontroller.addAction(alertaction1)
            alertcontroller.addAction(alertaction2)
            self.present(alertcontroller, animated: true, completion: nil)
        }
        else{
            if let indexPath = self.myCollectionView.indexPath(for: cell) {
                
                cartItem.productName = ProductInitializer.prodShared.prodList[indexPath.row].productName
                cartItem.rate = ProductInitializer.prodShared.prodList[indexPath.row].price
                let rowInPicker = cell.qtyPickerView.selectedRow(inComponent: 0)
                if (cell.qtyArr[rowInPicker] == 0)
                {
                    let alertcontroller = UIAlertController(title: "Quantity not defined", message: "Select the quantity from pickerview", preferredStyle: UIAlertControllerStyle.alert)
                    alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                    self.present(alertcontroller, animated: true, completion: nil)
                }
                else
                {
                    cartItem.qty = cell.qtyArr[rowInPicker]
                    Variables.isAddedToCart = true
                    self.myCollectionView.reloadItems(at: [indexPath])
                    print("Added to cart")
                }
                
            }
        }
    }
}
