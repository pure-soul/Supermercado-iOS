//
//  LeftMenuVC.swift
//  FAPanels
//
//  Created by Fahid Attique on 17/06/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class LeftMenuVC: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    fileprivate var menuOptions: [String]!
    
    @IBOutlet var name: UITextView!
    
    override func viewDidLoad() {
        
        if UserDefaults.standard.stringArray(forKey: "menuOptions") != nil{
            menuOptions = UserDefaults.standard.stringArray(forKey: "menuOptions")!
        }else{
            menuOptions = ["Cart", "Search", "Locate", "Profile", "Community", "Login"]
        }
        
        name.text = UserDefaults.standard.string(forKey: "username")
        
        super.viewDidLoad()
        print("Panel Started")
        // Do any additional setup after loading the view.
        
        viewConfigurations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    private func viewConfigurations() {
        
        tableView.register(UINib.init(nibName: "LeftMenuCell", bundle: nil), forCellReuseIdentifier: "LeftMenuCell")
    }
}


extension LeftMenuVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell") as! LeftMenuCell
        cell.menuOption.text = User.menuOptions[indexPath.row]
        cell.menuImage.image = UIImage(named: "right_menu_" + String(indexPath.row + 1))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var identifier = ""

        if indexPath.row == 0 {
            identifier = "CenterVC1"
        }else if indexPath.row == 1 {
            identifier = "CenterVC2"
        }else if indexPath.row == 2 {
            identifier = "CenterVC3"
        }else if indexPath.row == 3 {
            identifier = "CenterVC4"
        }else if indexPath.row == 4 {
            identifier = "CenterVC5"
        }else if indexPath.row == 5 {
            identifier = "Login"
        }
        let centerVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
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
        
    }
}
