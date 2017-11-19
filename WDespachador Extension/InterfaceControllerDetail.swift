//
//  InterfaceControllerDetail.swift
//  WDespachador Extension
//
//  Created by MBG on 11/16/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import WatchKit
import UIKit

class InterfaceControllerDetail: WKInterfaceController {
    
    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var time: WKInterfaceLabel!
    @IBOutlet var distance: WKInterfaceLabel!
    @IBOutlet var capacity: WKInterfaceLabel!
    @IBOutlet var driver: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let bus = context as! Bus
        self.image.setImage(bus.plateImage)
        self.time.setText("\(bus.time!) min.")
        self.distance.setText("\(bus.distance!) m.")
        self.capacity.setText("\(bus.capacity!)%")
        self.driver.setText("\(bus.driver!)")
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
