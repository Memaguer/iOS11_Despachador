//
//  ViewControllerNoteDetail.swift
//  Despachador
//
//  Created by MBG on 11/2/17.
//  Copyright © 2017 MBG. All rights reserved.
//

import UIKit

class ViewControllerNoteDetail: UIViewController {
    
    @IBOutlet var titlenote: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var detailNote: UITextView!
    @IBOutlet var category: UILabel!
    
    var note: Log!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titlenote.text = self.note.title
        self.date.text = self.note.date
        self.category.text = self.note.category
        self.detailNote.text = self.note.detail
        //self.image.image = self.note.image
        self.image.image = #imageLiteral(resourceName: "bus-wait")
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
