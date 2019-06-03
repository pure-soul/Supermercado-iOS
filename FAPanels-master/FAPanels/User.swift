//
//  User.swift
//  FAPanels
//
//  Created by Shemar Henry on 01/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation

class User{
    
    static var menuOptions = ["Cart", "Search", "Locate", "Profile", "Community", "Login"]
    
    static var url: String = "http://10.3.0.54:5000/supermercado/api/v1.0/"
    var username: String = ""
    var email: String!
    var id: String!
    
    func logout(){
        self.username = ""
        self.email = ""
        self.id = ""
    }

}
