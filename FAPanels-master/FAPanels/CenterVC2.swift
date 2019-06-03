//
//  CenterVC2.swift
//  FAPanels
//
//  Created by Shemar Henry on 03/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import UIKit
import AudioToolbox

class CenterVC2: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var items: [Item] = []
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath) as! SearchCell
        
        let item: Item
        
        item = items[indexPath.row]
        
        cell.addToCart = {
            if UserDefaults.standard.stringArray(forKey: "username") != nil{
                self.generator.impactOccurred()
                //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                CartList.cartList.append(item)
                item.setQuantity(quan: 1)
                tableView.reloadData()
            }else{
                let alert = UIAlertController(title: "Please Login", message: "This Feature Requires You To Be Logged In", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
        
        cell.add = {
            item.addOne()
            tableView.reloadData()
        }
        
        cell.minus = {
            item.minusOne()
            tableView.reloadData()
        }
        
        cell.name.text = item.getName()
        cell.descrip.text = item.getContent()
        cell.quan.text = String(item.getQuantity())
        cell.cost.text = String(item.getCost()*Float(item.getQuantity()))
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfigurations()
        
        QueryItems(query: "popular")
        tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Supermarket"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Before Search: ")
        print(self.items)
        QueryItems(query: searchText)
        print("After Search: ")
        print(self.items)
        self.tableView.reloadData()
        print("After Search Reload Data: ")
    }
    
    //    func checkforLogin(){
    //        if UserDefaults.standard.string(forKey: "username") == ""{
    //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //            let secondViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! Login
    //            self.present(secondViewController, animated: true, completion: nil)//Launch Login
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func showLeftVC(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    private func viewConfigurations() {
        tableView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "search_cell")
    }
    
}

extension CenterVC2: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! != "" {
            filterContentForSearchText(searchController.searchBar.text!)
        }
    }
}

extension CenterVC2{
    
    func QueryItems(query: String) {
        
        let search = CartList.url + query
        guard let url = URL(string: search.lowercased()) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
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
                    self.items = []
                    self.tableView.reloadData()
                    
                    if jsonArray.count == 0{
                        let alert = UIAlertController(title: "Not Avaialble", message: "Check Back Again Later", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                    for json in jsonArray{
                        let item = Item()
                        item.setName(name: (json["title"] as? String)!)
                        print(item.getName())
                        item.setID(id: (json["id"] as? Int)!)
                        if let n = json["price"] as? NSNumber {
                            let cost = n.floatValue
                            item.setCost(cost: cost)
                        }
                        item.setIsleNum(isle: (json["isle_no"] as? Int)!)
                        item.setAvailable(amt: (json["quantity"] as? Int)!)
                        item.setContent(content: (json["content"] as? String)!)
                        self.items.append(item)
                        self.tableView.reloadData()
                    }
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
