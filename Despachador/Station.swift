//
//  Station.swift
//  Despachador
//
//  Created by MBG on 11/19/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class Station: NSObject {
    
    var id : Int!
    var name : String!
    var image : UIImage!
    
    init(id: Int, name:String){
        self.id = id
        self.name = name
        self.image = UIImage(named: "logo-\(name).png")
    }

}
