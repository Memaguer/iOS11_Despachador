//
//  Bus.swift
//  WDespachador Extension
//
//  Created by MBG on 11/16/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class Bus: NSObject {
    var licensePlate : String!
    var station : Int!
    var driver : String!
    var distance: Int!
    var capacity : Int!
    var time : Int!
    var plateImage : UIImage!
    var busImage : UIImage!
    
    init(licensePlate: String, driver:String, distance:Int, capacity: Int, time: Int){
        self.plateImage = UIImage(named: "\(licensePlate).png")
        self.busImage = #imageLiteral(resourceName: "nextBus")
        self.licensePlate = licensePlate
        self.driver = driver
        self.distance = distance
        self.capacity = capacity
        self.time = time
    }

}
