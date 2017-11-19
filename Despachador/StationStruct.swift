//
//  StationStruct.swift
//  Despachador
//
//  Created by MBG on 11/12/17.
//  Copyright © 2017 MBG. All rights reserved.
//

struct StationStruct: Codable{
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
