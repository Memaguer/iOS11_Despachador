//
//  TableViewCellNote.swift
//  Despachador
//
//  Created by MBG on 11/1/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class TableViewCellNote: UITableViewCell {
    @IBOutlet var imageNote: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
