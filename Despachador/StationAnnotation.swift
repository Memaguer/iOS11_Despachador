//
//  StationAnnotation.swift
//  Despachador
//
//  Created by MBG on 11/12/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import MapKit

class StationAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var subtitle: String?
    var title: String?
    
    init (coordinate: CLLocationCoordinate2D, name: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = name
        self.subtitle = subtitle
    }
    
}
