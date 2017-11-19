//
//  StationWStruct.swift
//  WDespachador Extension
//
//  Created by MBG on 11/18/17.
//  Copyright © 2017 MBG. All rights reserved.
//

struct StationWStruct: Codable{
    var result: [Stations]
}

struct Stations: Codable{
    var id: Int
    var name: String
    var base: Bool
    var latitude: Double
    var longitude: Double
    var manager: String
    var passenger: Int
    var route: String
}
