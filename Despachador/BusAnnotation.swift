//
//  BusAnnotation.swift
//  Despachador
//
//  Created by MBG on 11/7/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit
import MapKit

class BusAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    var subtitle: String?
    var title: String?
    
    init (coordinate: CLLocationCoordinate2D, licensePlate: String, subtitle: String) {
        self.coordinate = coordinate
        self.subtitle = subtitle
        self.title = licensePlate
    }

}
