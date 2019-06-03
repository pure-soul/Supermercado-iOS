//
//  CenterVC4.swift
//  FAPanels
//
//  Created by Shemar Henry on 02/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class CenterVC4: UIViewController{
    
    @IBOutlet var name: UITextView!
    @IBOutlet var email: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = UserDefaults.standard.string(forKey: "username")
        email.text = UserDefaults.standard.string(forKey: "email")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func logoutAndStepPonChiChiMan(){
        if User.menuOptions.count == 5{
            User.menuOptions.append("Login")
            UserDefaults.standard.set("", forKey: "username")
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "id")
            UserDefaults.standard.set(["Cart", "Search", "Locate", "Profile", "Community", "Login"], forKey: "menuOptions")
            let alert = UIAlertController(title: "Logout Successful", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "Invalid Request", message: "You Must First Be Logged In To Perform Logout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func getToBlog(){
        //route to blog
    }
}
