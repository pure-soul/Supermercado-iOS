//
//  CartList.swift
//  FAPanels
//
//  Created by Shemar Henry on 30/05/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation

class CartList{
    static var qrList: [QRCode] = []
    static var url: String = "http://10.3.0.54:5000/supermercado/api/v1.0/search2/"
    static var cartList: [Item] = []
    
    static func addToCartList(item: Item){
        self.cartList.append(item)
    }
    
    static func checkOut(){
        self.cartList = []
    }
}
