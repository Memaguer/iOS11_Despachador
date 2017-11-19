//
//  Station.swift
//  WDespachador Extension
//
//  Created by MBG on 11/18/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class Station: NSObject {
    
    var id : Int!
    var image : UIImage!
    var name : String!
    var passenger : Int!
    var buses : [Bus]!
    
    init(name: String, id : Int, passenger: Int){
        self.id = id
        self.name = name
        self.passenger = passenger
        self.image = UIImage(named: "logo-\(name).png")
        if id==8 {
            self.image = UIImage(named: "logo-\(id).png")
        }
    }
    
    func insertBuses(buses: [Bus]){
        self.buses = buses
    }
}
