//
//  MenuCollectionViewCell.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit


class MenuCollectionViewCell: BaseCell {
    
    
    
    static let cellId = "cellMenu"
    
    
    let settingsLabel : UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "Helvetica Neue", size: 14.0)
        
       
        return label
        
    }()
    
 
    
 
    
    override func setupViews() {
        super.setupViews()
        
        setConstraint()
        
    }
    
    
    
    private func setConstraint() {
        
        
        addSubview(settingsLabel)
        
        
        settingsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        settingsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
                
    }
}
