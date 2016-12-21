//
//  TableViewCell.swift
//  iFlat
//
//  Created by Alican Yilmaz on 18/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgv: UIImageView!
    var index:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
