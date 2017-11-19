//
//  Note.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class Note: NSObject {
    
    var title: String!
    var date: String!
    var image: UIImage!
    var category: String!
    var detail: String!
    
    /*init(title: String, date: String, image: UIImage, category: String, detail: String){
        self.title = title
        self.date = date
        self.image = image
        self.category = category
        self.detail = detail
    }*/
    
    init(title: String, date: String, category: String, detail: String){
        self.title = title
        self.date = date
        self.category = category
        self.detail = detail
        
        switch category{
        case "Unidad":
            self.image = #imageLiteral(resourceName: "bus-wrong")
            break
        case "Pasajeros":
            self.image = #imageLiteral(resourceName: "bus-wait")
            break
        case "Despachador":
            self.image = #imageLiteral(resourceName: "bus-check")
            break
        default:
            self.image = #imageLiteral(resourceName: "bus-arrive")
        }
    }

}
