//
//  SearchCell.swift
//  FAPanels
//
//  Created by Shemar Henry on 31/05/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class SearchCell: UITableViewCell{
    
    @IBOutlet var name: UITextView!
    @IBOutlet var descrip: UITextView!
    @IBOutlet var quan: UITextView!
    @IBOutlet var cost: UITextView!
    
    var addToCart: (() -> Void)? = nil
    var add: (() -> Void)? = nil
    var minus: (() -> Void)? = nil
    
    @IBAction func cartButton(sender: UIButton) {
        addToCart?()
    }
    
    @IBAction func add(sender: UIButton){
        add?()
    }
    
    @IBAction func minus(sender: UIButton){
        minus?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}
