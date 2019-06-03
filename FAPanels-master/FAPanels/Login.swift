//
//  Login.swift
//  FAPanels
//
//  Created by Shemar Henry on 01/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class Login: UIViewController{
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func login(){

        if username.text! != "" || password.text! != ""{
            Login(username: username.text!, password: password.text!)
            User.menuOptions.remove(at: 5)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "CenterVC2")
            let centerNavVC = UINavigationController(rootViewController: centerVC)
            
            panel!.configs.bounceOnCenterPanelChange = true
            
            /*
             // Simple way of changing center PanelVC
             _ = panel!.center(centerNavVC)
             */
            
            
            
            /*
             New Feature Added, You can change the center panelVC and after completion of the animations you can execute a closure
             */
            
            panel!.center(centerNavVC, afterThat: {
                print("Executing block after changing center panelVC From Left Menu")
                //            _ = self.panel!.left(nil)
            })
        }else{
            let alert = UIAlertController(title: "Blank Submission", message: "Please Add Information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
}

extension Login{
    
    func Login(username: String, password: String) {
        
        let search = User.url + username + "/" + password
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
                        //self.switchView()
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
