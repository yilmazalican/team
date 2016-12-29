//
//  Issue.swift
//  iFlat
//
//  Created by Alican Yilmaz on 29/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import Firebase
class Issue

{
    private let dbEndpoint = FIRUSER()
    let ID:String
    let title:String
    let content:String
    var isOpen:Bool
    var issued:User
    var issuer:User
    var answer:String?
    
    
    init(title:String,content:String,issued:User){
        self.ID = UUID().uuidString
        self.isOpen = true
        self.title = title
        self.content = content
        self.issued = issued
        self.issuer = User()
        setIssuer()
    }
    
    func setIssuer()
    {
        dbEndpoint.getCurrentLoggedIn { (usr) in
            self.issuer = usr as! User
        }
    }
    
    
    

}
