//
//  TabBarController.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
