//
//  TabBarController.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var stationId: Int!
    var nextBuses: [Bus]!
    var actualBuses: [Bus]!
    var onRouteBuses : [Bus]!
    var flagTwo = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
        /*print("TabBar - nextBuses count: \(nextBuses.count)")
        
        print(flagTwo)
        if self.flagTwo == true{
            print(flagTwo)
            performSegue(withIdentifier: "TabNavSegue", sender: self)
        }*/
        
        /*
        let navController = self.tabBarController?.viewControllers![0] as! UINavigationControllerTable
        let viewControllerTables = navController.topViewController as! ViewControllerTables
        viewControllerTables.routeId = self.routeId!
        viewControllerTables.stationId = self.stationId!*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationControllerTable
        navigationController.nextBuses = self.nextBuses
        navigationController.actualBuses = self.actualBuses
        navigationController.onRouteBuses = self.onRouteBuses
        navigationController.stationId = self.stationId
        print("=== entra a prepare de Tab")
        self.flagTwo = true
    }*/

}
