//
//  FIRREF.swift
//  iFlat
//
//  Created by Alican Yilmaz on 03/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FIRREF
{   private var ref:FIRDatabaseReference!
    private var storageRef:FIRStorageReference!
    private static var singleton = FIRREF()
    
    
    private init()
    {
        
    }

    
    static func instance() -> FIRREF
    {
        return singleton
    }
    
    internal func getRef() -> FIRDatabaseReference {
    self.ref = FIRDatabase.database().reference()
    return self.ref
    }
    
    internal func getStorageRef() -> FIRStorageReference
    {
        self.storageRef = FIRStorage.storage().reference()
        return self.storageRef
    }
}
