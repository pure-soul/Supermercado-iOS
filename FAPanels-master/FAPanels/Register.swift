//
//  Register.swift
//  FAPanels
//
//  Created by Shemar Henry on 01/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class Register: UIViewController{
    
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var repass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Register(){
        if username.text! != "" && password.text! != "" && email.text! != "" && repass.text! != ""{
            if password.text! == repass.text!{
                register(username: username.text!, password: password.text!, email: email.text!)
            }else{
                let alert = UIAlertController(title: "Password Mis-Match", message: "Check Passwords and Try Again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "Blank Submission", message: "Please Add Information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension Register{
    
    func register(username: String, password: String, email: String) {
        
        let search = User.url + "register/" + username + "/" + password + "/" + email
        guard let url = URL(string: search.lowercased()) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    let alert = UIAlertController(title: "Cannot Login", message: "Please Check Information (or Internet Connection)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                print(jsonResponse) //Response result
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                print(jsonArray)
                //Now get title value
                DispatchQueue.main.async { // Correct
                    for json in jsonArray{
                        UserDefaults.standard.set(username, forKey: "username")
                        UserDefaults.standard.set((json["email"] as? String)!, forKey: "email")
                        UserDefaults.standard.set((json["id"] as? String)!, forKey: "id")
                        UserDefaults.standard.set(["Cart", "Search", "Locate", "Profile", "Community"], forKey: "menuOptions")
                    }
                }
            } catch let parsingError {
                let alert = UIAlertController(title: "Cannot Login", message: "Please Check Information (or Internet Connection)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(alert, animated: true)
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
