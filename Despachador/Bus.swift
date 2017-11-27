//
//  Bus.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class Bus: NSObject, NSCoding {
    var licensePlate : String!
    var station : Int!
    var driver : String!
    var distance: Int!
    var capacity : Int!
    var time : Int!
    var comments: [String]!
    var plateImage : UIImage!
    var capacityImage : UIImage!
    
    init(licensePlate: String, driver:String, distance:Int, capacity: Int, time: Int){
        self.plateImage = UIImage(named: "\(licensePlate).png")
        self.licensePlate = licensePlate
        self.driver = driver
        self.distance = distance
        self.capacity = capacity
        self.time = time
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let licensePlate = aDecoder.decodeInteger(forKey: "licensePlate") as! String
        let station = aDecoder.decodeInteger(forKey: "station") as! String
        let driver = aDecoder.decodeInteger(forKey: "driver") as! String
        let distance = aDecoder.decodeInteger(forKey: "distance")
        let capacity = aDecoder.decodeInteger(forKey: "capacity")
        let time = aDecoder.decodeInteger(forKey: "time")
        let plateImage = aDecoder.decodeInteger(forKey: "plateImage") as! UIImage
        self.init(licensePlate: licensePlate, driver: driver, distance: distance, capacity: capacity, time: time)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(licensePlate, forKey: "licensePlate")
        aCoder.encode(station, forKey: "station")
        aCoder.encode(driver, forKey: "driver")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(capacity, forKey: "capacity")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(plateImage, forKey: "plateImage")
    }
}
