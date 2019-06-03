//
//  Items.swift
//  FAPanels
//
//  Created by Shemar Henry on 30/05/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation

struct Items {
    
    let name: String
    let content: String
    let cost: Float
    let islenum: Int
    let available: Int
    let id: String
    let quantity: Int
}

extension Items {
    
    init?(_ dictionary: [String: Any]) throws {
        
        self.name = dictionary["title"] as? String ?? ""
        self.content = dictionary["content"] as? String ?? ""
        self.cost = dictionary["price"] as? Float ?? 0
        self.islenum = dictionary["islenum"] as? Int ?? 0
        self.available = dictionary["quantity"] as? Int ?? 0
        self.id = dictionary["id"] as? String ?? ""
        self.quantity = 0
    }
}
