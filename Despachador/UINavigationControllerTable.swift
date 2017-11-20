//
//  UINavigationControllerTable.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class UINavigationControllerTable: UINavigationController {
    
    /*var stationId: Int!
    var nextBuses: [Bus]!
    var actualBuses: [Bus]!
    var onRouteBuses : [Bus]!*/

    override func viewDidLoad() {
        super.viewDidLoad()
        /*print("UINavigation - nextBuses count: \(nextBuses.count)")
        performSegue(withIdentifier: "NavigationViewSegue", sender: self)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*let viewController = segue.destination as! ViewControllerTables
        viewController.nextBuses = self.nextBuses
        viewController.actualBuses = self.actualBuses
        viewController.onRouteBuses = self.onRouteBuses
        viewController.stationId = self.stationId*/
    }

}
