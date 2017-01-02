//
//  WishListTableView.swift
//  iFlat
//
//  Created by Tolga Taner on 1.01.2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class WishListTableView: UITableView , UITableViewDelegate,UITableViewDataSource {


    var flatImages = [String]()
    
    
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
            
            cell.flatIV.kf.setImage(with: URL(string:self.flatImages[indexPath.row]))
            return cell
        }
                else {
    
    return UITableViewCell()
    }
        
        
        
    }

}
