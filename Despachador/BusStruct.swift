//
//  BusResult.swift
//  Despachador
//
//  Created by MBG on 10/30/17.
//  Copyright © 2017 MBG. All rights reserved.
//

struct BusStruct: Codable{
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
