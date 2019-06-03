//
//  Item.swift
//  FAPanels
//
//  Created by Shemar Henry on 30/05/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation

class Item{
    
    var name: String!
    var id: Int!
    var content: String!
    var cost: Float!
    var available: Int!
    var quantity: Int!
    var isleNum: Int!
    
    init(){
        self.quantity = 1
        self.name = "Item Name"
        self.content = "Item Detail"
        self.cost = 0
    }
    
    func setName(name: String){
        self.name = name;
    }
    
    func setID(id: Int){
        self.id = id;
    }
    
    func setContent(content: String){
        self.content = content;
    }
    
    func setCost(cost: Float){
        self.cost = cost
    }
    
    func setAvailable(amt: Int){
        self.available = amt
    }
    
    func setIsleNum(isle: Int){
        self.isleNum = isle
    }
    
    func getName() -> String{
        return self.name
    }
    
    func getCost() -> Float{
        return self.cost
    }
    
    func getIsleNum() -> Int{
        return self.isleNum
    }
    
    func getContent() -> String{
        return self.content
    }
    
    func getQuantity() -> Int{
        return self.quantity
    }
    
    func setQuantity(quan: Int){
        self.quantity = quan
    }
    
    func addOne(){
        if self.quantity < self.available{
            self.quantity = self.quantity + 1
        }
    }
    
    func minusOne(){
        if self.quantity > 1{
            self.quantity = self.quantity - 1
        }
    }

}

extension Item {
    
    static var url: String = "http://127.0.0.1:5000/supermercado/api/v1.0/search/"
    static var items: [Item] = []
    
    static func items(query: String) -> [Item] {
        
        let search = url + query
        guard let url = URL(string: search.lowercased()) else {return []}
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
                items = []
                for json in jsonArray{
                    let item = Item()
                    item.setName(name: (json["title"] as? String)!)
                    print(item.getName())
                    item.setID(id: (json["id"] as? Int)!)
                    if let n = json["price"] as? NSNumber {
                        let cost = n.floatValue
                        item.setCost(cost: cost)
                    }
                    item.setIsleNum(isle: (json["islenum"] as? Int)!)
                    item.setAvailable(amt: (json["quantity"] as? Int)!)
                    item.setContent(content: (json["content"] as? String)!)
                    items.append(item)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        return items
    }
}
