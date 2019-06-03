//
//  QRCell.swift
//  FAPanels
//
//  Created by Shemar Henry on 02/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class QRCell: UITableViewCell{
    
    
    //@IBOutlet var qrimage: UIImageView!
    @IBOutlet var qrtitle: UITextView!
    @IBOutlet var qrimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}
