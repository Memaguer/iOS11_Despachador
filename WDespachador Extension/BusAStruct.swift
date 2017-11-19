//
//  BusStruct.swift
//  WDespachador Extension
//
//  Created by MBG on 11/16/17.
//  Copyright © 2017 MBG. All rights reserved.
//

struct BusAStruct: Codable{
    var result: [Buses]
}

struct Buses: Codable{
    var licensePlate: String
    var driver: String
    var distance: Int
    var time: Int
    var capacity: Int
    var station: Int
    var latitude: Double
    var longitude: Double
}
