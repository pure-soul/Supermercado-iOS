//
//  QRCode.swift
//  FAPanels
//
//  Created by Shemar Henry on 02/06/2019.
//  Copyright © 2019 Fahid Attique. All rights reserved.
//

import Foundation
import UIKit

class QRCode{
    
    static var codes: [QRCode] = []
    let dateFormatter = DateFormatter()
    
    var qrcodeString: String!
    //var qrcodeImage: UIImage!
    var qrcodeTitle: String!
    var qrID: UUID!
    var qrImage: UIImage!
    
    init(){
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        self.qrID = UUID()
        self.qrcodeTitle = dateFormatter.string(from: NSDate(timeIntervalSince1970: 1415637900) as Date)
        self.qrcodeString = UserDefaults.standard.string(forKey: "username")!.uppercased() + "-" + self.qrID.uuidString
    }
    
    func getTitle() -> String{
        return self.qrcodeTitle
    }
    
    func getID() -> UUID{
        return self.qrID
    }
    
    func getString() -> String{
        return self.qrcodeString
    }
    
    func setImage(image: UIImage){
        self.qrImage = image
    }
    
    func getImage() -> UIImage{
        return self.qrImage
    }
    
}
