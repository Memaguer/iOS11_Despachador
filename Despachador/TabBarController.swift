//
//  TabBarController.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var routeId: Int?
    var stationId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("A- routeId: \(self.routeId!)")
        print("A- stationId: \(self.stationId!)")
        
        /*
        let navController = self.tabBarController?.viewControllers![0] as! UINavigationControllerTable
        let viewControllerTables = navController.topViewController as! ViewControllerTables
        viewControllerTables.routeId = self.routeId!
        viewControllerTables.stationId = self.stationId!*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
