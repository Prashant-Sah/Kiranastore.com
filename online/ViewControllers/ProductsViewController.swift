//
//  ProductsViewController.swift
//  online
//
//  Created by Prashant Sah on 3/9/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit
import Alamofire

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    
    var cartItem: UserCart = UserCart()
    
    var product : ProductsOnWeb!
    //var products = [ProductsOnWeb]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Variables.isLoggedIn {
            
            loginBarButton.isEnabled = false
            loginBarButton.tintColor = UIColor.clear
            logoutBarButton.isEnabled = true
            logoutBarButton.tintColor = UIColor.black
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductsViewController.ifLoggedIn), name: Notification.Name("LOGINSUCCESFULLNOTIFICATION"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProductsViewController.ifLoggedOut) , name: LOGOUTSUCCESFULLNOTIFICATION, object: nil)
        
        let nibName = UINib(nibName: "ProductsCollectionViewCell", bundle: nil)
        self.myCollectionView.register(nibName, forCellWithReuseIdentifier: "ProdCell")
        
        initializeCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK - NSNotification works
extension ProductsViewController {
    
    func ifLoggedIn(){
        
        loginBarButton.isEnabled = false
        loginBarButton.tintColor = UIColor.clear
        logoutBarButton.isEnabled = true
        logoutBarButton.tintColor = UIColor.black
        
    }
    
    func ifLoggedOut(){
        loginBarButton.isEnabled = true
        logoutBarButton.isEnabled = false
        loginBarButton.tintColor = UIColor.black
        logoutBarButton.tintColor = UIColor.clear
        
        Variables.isAddedToCart = false
        Variables.isLoggedIn = false
        self.myCollectionView.reloadData()
        //self.viewDidLoad()
        //UserDefaults.standard.removeObject(forKey: "checklogin1" )
        //UserDefaults.standard.removeObject(forKey: "checklogin2" )
    }
}
//MARK-  Collection View Initialized here
extension ProductsViewController{
    func initializeCollectionView(){
        
        ProductInitializer.prodShared.products.removeAll()
        let url: String = "http://localhost/products/products.php"
        let urlRequest = URL(string: url)
        
        Alamofire.request(url, method: .get, parameters: ["test":"test"]).responseJSON(completionHandler: { [weak self] response in
            
            print (response.data!)
            if let obtainedData = response.result.value{
                print (obtainedData)
                let dataDict = obtainedData as? [Dictionary<String, AnyObject>]
                
                for obj in dataDict!
                {
                    let product = ProductsOnWeb(ProductDict: obj)
                    //self.products.append(product)
                    ProductInitializer.prodShared.products.append(product)
                    
                }
                self?.myCollectionView.reloadData()
            }
        })
        
        /*
        //with Alamofire
        
        Alamofire.request(urlRequest!).responseJSON { response in
            
            print (response.data!)
            if let obtainedData = response.result.value{
                print (obtainedData)
                let dataDict = obtainedData as? [Dictionary<String, AnyObject>]
                
                for obj in dataDict!
                {
                    let product = ProductsOnWeb(ProductDict: obj)
                    //self.products.append(product)
                    ProductInitializer.prodShared.products.append(product)
                    
                }
                self.myCollectionView.reloadData()
            }
        }
 
 */
        
        // with URLSession
        
        //        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
        //            ( data , response ,error ) in
        //            if(error != nil)
        //            {
        //                print(error.debugDescription)
        //            }
        //            else{
        //                do
        //                {
        //                    let obtainedData = try! JSONSerialization.jsonObject(with: data!, options: [] )
        //
        //                    print(obtainedData)
        //
        //                    let dataDict = obtainedData as? [Dictionary<String, AnyObject>]
        //
        //                    for obj in dataDict!
        //                    {
        //                        let product = ProductsOnWeb(ProductDict: obj)
        //                        //self.products.append(product)
        //                        ProductInitializer.prodShared.products.append(product)
        //
        //                    }
        //                    self.myCollectionView.reloadData()
        //                }
        //            }
        //        }).resume()
    }
}

// MARK - Bar Button handlers
extension ProductsViewController{
    @IBAction func loginPressed(_ sender: UIBarButtonItem) {
        
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let navVC = UINavigationController(rootViewController: loginVC)
            //self.navigationController?.pushViewController(loginVC, animated: true)
            self.present(navVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: LOGOUTSUCCESFULLNOTIFICATION, object: self)
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
        return ProductInitializer.prodShared.products.count
        //return ProductInitializer.prodShared.prodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "ProdCell", for: indexPath) as? ProductsCollectionViewCell {
            
            //cell.configureProduct(product: ProductInitializer.prodShared.prodList[indexPath.row])
            let singleProduct = ProductInitializer.prodShared.products[indexPath.row]
            //cell.qtyPickerView.reloadAllComponents()
            cell.configureProduct(product: singleProduct)
            cell.delegate = self
            return cell
        } else{
            return ProductsCollectionViewCell()
        }
        
    }
    
    func didAddToCart(cell: ProductsCollectionViewCell) {
        
        //self.showAlert(message: "Do you want to add this to cart?", ok
        //            }
        //        }, cancel: {
        //        })
        
        if Variables.isLoggedIn == false {
            
            let alertcontroller = UIAlertController(title: "Login Required", message: "Press Signin button to continue", preferredStyle: UIAlertControllerStyle.alert)
            let alertaction1 = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alertaction2 = UIAlertAction(title: "Canel", style: .cancel, handler: nil)
            alertcontroller.addAction(alertaction1)
            alertcontroller.addAction(alertaction2)
            self.present(alertcontroller, animated: true, completion: nil)
            
        } else {
            
            if let indexPath = self.myCollectionView.indexPath(for: cell) {
                cartItem.productName = cell.prodLabel.text
                //Eliminating "Rs." from price label
                let numeralsOnlyIndex = cell.prodPrice.text?.index((cell.prodPrice.text?.startIndex)!, offsetBy: 3)
                cartItem.rate = Int((cell.prodPrice.text?.substring(from: numeralsOnlyIndex!))!)
                
                let rowInPicker = cell.qtyPickerView.selectedRow(inComponent: 0)
                if (cell.qtyArr[rowInPicker] == 0) {
                    
                    let alertcontroller = UIAlertController(title: "Quantity not defined", message: "Select the quantity from pickerview", preferredStyle: UIAlertControllerStyle.alert)
                    alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                    self.present(alertcontroller, animated: true, completion: nil)
                    
                } else {
                    
                    cartItem.qty = cell.qtyArr[rowInPicker]
                    Variables.selectedQty = cartItem.qty
                    Variables.isAddedToCart = true
                    self.myCollectionView.reloadItems(at: [indexPath])
                    print("Added to cart")
                    
                }
                
            }
        }
    }
}
