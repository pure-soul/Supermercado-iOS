//
//  CenterVC3.swift
//  FAPanels
//
//  Created by Shemar Henry on 30/05/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class CenterVC3: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: [Item] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfigurations()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locate_cell", for: indexPath) as! FindCell
        let item: Item
        
        item = items[indexPath.row]
        
        cell.name.text = item.getName()
        cell.islenum.text = String(item.getIsleNum())
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Before Search: ")
        print(self.items)
        queryItems(query: searchText)
        print("After Search: ")
        print(self.items)
        self.tableView.reloadData()
        print("After Search Reload Data: ")
    }
    
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
        tableView.register(UINib.init(nibName: "LocateCell", bundle: nil), forCellReuseIdentifier: "locate_cell")
    }
    
}

extension CenterVC3: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! != "" {
            filterContentForSearchText(searchController.searchBar.text!)
        }
    }
}

extension CenterVC3{
    
    func queryItems(query: String) {
        
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
