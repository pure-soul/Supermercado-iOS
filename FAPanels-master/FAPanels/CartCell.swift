//
//  CartCell.swift
//  FAPanels
//
//  Created by Shemar Henry on 01/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class CartCell: UITableViewCell{
    
    @IBOutlet var cname: UITextView!
    @IBOutlet var cost: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}
