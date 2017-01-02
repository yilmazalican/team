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
    var ID:String?
    var title:String?
    var content:String?
    var isOpen:Bool?
    var issued:String?
    var issuer:String?
    var answer:String?
    
    
    init(title:String,content:String,issued:String){
        self.ID = UUID().uuidString
        self.isOpen = true
        self.title = title
        self.content = content
        self.issued = issued
        self.issuer = ""
        setIssuer()
    }
    
    func setIssuer()
    {
        dbEndpoint.getCurrentLoggedIn { (usr) in
            self.issuer = usr!.id!
        }
    }
    
    init() {
         self.ID = UUID().uuidString
    }
    
    
    
    
    

}
