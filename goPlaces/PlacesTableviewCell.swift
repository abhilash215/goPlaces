//
//  PlacesTableviewCell.swift
//  goPlaces
//
//  Created by abhilash uday on 12/10/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import Foundation
import UIKit

class PlacesTableviewCell: UITableViewCell {
    
   
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var adresstext: UITextField!
    @IBOutlet weak var name: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
