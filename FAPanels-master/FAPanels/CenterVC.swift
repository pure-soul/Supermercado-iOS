//
//  CenterVC.swift
//  FAPanels
//
//  Created by Fahid Attique on 17/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit


class CenterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartList.cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart_cell", for: indexPath) as! CartCell
        let item: Item
        
        item = CartList.cartList[indexPath.row]
        
        cell.cname.text = String(item.getQuantity()) + " " + item.getName()
        cell.cost.text = String(item.getCost()*Float(item.getQuantity()))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CartList.cartList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //  MARK:- Class Properties
    
    //  MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        viewConfigurations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func viewConfigurations() {
        tableView.register(UINib.init(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "cart_cell")
    }
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func checkOut(){
        if CartList.cartList.count != 0 {
            let qrcode: QRCode = QRCode()
            qrcode.setImage(image: generateQRCode(from: qrcode.getString())!)
            CartList.qrList.append(qrcode)
            PostItems(str: qrcode.getString())
            CartList.checkOut()
            tableView.reloadData()
            let alert = UIAlertController(title: "Check Trasactions", message: "When Ready To Collect, Go To Profile and Access Pick-Up Code in Transactions", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

extension CenterVC{
    
    func PostItems(str: String) {
        //Method To Post List To Server
    }
}
