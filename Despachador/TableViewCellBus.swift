//
//  TableViewCellBus.swift
//  Despachador
//
//  Created by MBG on 10/29/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class TableViewCellBus: UITableViewCell {
    
    @IBOutlet var plateImage: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var capacityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
