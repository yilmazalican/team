//
//  FlatOptionTableView.swift
//  iFlat
//
//  Created by Tolga Taner on 13.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatOptionTableView: UITableView {

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        dataSource = self
    }
    
    
}
extension FlatOptionTableView : UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : FlatOptionTableViewCell = dequeueReusableCell(withIdentifier:FlatOptionTableViewCell.cellId, for: indexPath)  as? FlatOptionTableViewCell{
            
            
            
            
            return cell
        }
        else {
            
 return  FlatOptionTableViewCell()
            
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
}
