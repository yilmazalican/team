//
//  RenterEditOwnProfileTableView.swift
//  iFlat
//
//  Created by Tolga Taner on 5.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class RenterEditOwnProfileTableView: UITableView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        delegate = self
        dataSource = self
    }
  
}

extension RenterEditOwnProfileTableView: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if let cell : RenterEditOwnProfileTableViewCell = dequeueReusableCell(withIdentifier: RenterEditOwnProfileTableViewCell.cellId, for: indexPath) as? RenterEditOwnProfileTableViewCell {
            
       
           
            return cell 
        }
        
        else {
            
            return  RenterEditOwnProfileTableViewCell()
            
        }
        
        
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return 1
    }
    
    
    
    
    
}
