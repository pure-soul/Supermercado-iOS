//
//  Transactions.swift
//  FAPanels
//
//  Created by Shemar Henry on 02/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit


class Transactions: UITableViewController  {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartList.qrList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qr_cell", for: indexPath) as! QRCell
        let item: QRCode
        
        item = CartList.qrList[indexPath.row]
        
        cell.qrtitle.text = item.getTitle()
        cell.qrimage.image = item.getImage()
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CartList.qrList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //  MARK:- Class Properties
    
    //  MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewConfigurations()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    private func viewConfigurations() {
        tableView.register(UINib.init(nibName: "QRCell", bundle: nil), forCellReuseIdentifier: "qr_cell")
    }
}

extension Transactions{
    
    func fetchImage(str: String) -> UIImage{
        
        var uimage: UIImage = UIImage()
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            filter.setValue(str, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                
                uimage = UIImage(ciImage: output)
            }
        }
        return uimage
    }
}

