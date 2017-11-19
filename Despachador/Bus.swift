//
//  Bus.swift
//  Despachador
//
//  Created by MBG on 10/28/17.
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
    
    init(plateImage:UIImage, plate: String, driver:String, distance:Int, capacity: Int, time: Int, comments:[String]){
        self.plateImage = plateImage
        self.licensePlate = plate
        self.driver = driver
        self.distance = distance
        self.comments = comments
        self.capacity = capacity
        self.time = time
        if capacity<35{
            capacityImage = #imageLiteral(resourceName: "capacity_25")
        }
        else if capacity<60{
            capacityImage = #imageLiteral(resourceName: "capacity_50")
        }
        else if capacity<85{
            capacityImage = #imageLiteral(resourceName: "capacity_75")
        }
        else{
            capacityImage = #imageLiteral(resourceName: "capacity_100")
        }
    }
}
