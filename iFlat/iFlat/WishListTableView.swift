//
//  WishListTableView.swift
//  iFlat
//
//  Created by Tolga Taner on 1.01.2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class WishListTableView: UITableView , UITableViewDelegate,UITableViewDataSource {


    var flatImages = [FlatImage]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        dataSource = self
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flatImages.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: Wishcell = dequeueReusableCell(withIdentifier: "Wishcell", for: indexPath) as? Wishcell{
            
            cell.flatIV.image = flatImages[indexPath.row].image
            return cell
        }
                else {
    
    return UITableViewCell()
    }
        
        
        
    }

}
