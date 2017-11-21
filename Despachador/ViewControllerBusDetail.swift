//
//  ViewControllerBusDetail.swift
//  Despachador
//
//  Created by MBG on 10/29/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class ViewControllerBusDetail: UIViewController {
    
    @IBOutlet var plateImage: UIImageView!
    @IBOutlet var plateLabel: UILabel!
    @IBOutlet var driverLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var capacityLabel: UILabel!
    
    var bus: Bus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plateImage.image = self.bus.plateImage
        self.plateLabel.text = self.bus.licensePlate
        self.driverLabel.text = "chofer \(self.bus.driver!)"
        self.distanceLabel.text = "a \(self.bus.distance!) metros"
        self.timeLabel.text = "a \(self.bus.time!) minutos aprox"
        self.capacityLabel.text = "capacidad del \(self.bus.capacity!)%"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
