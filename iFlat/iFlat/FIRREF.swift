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
{   var ref:FIRDatabaseReference!
    var storageRef:FIRStorageReference!
    static let instance = FIRREF()
    
    func getRef() -> FIRDatabaseReference {
    self.ref = FIRDatabase.database().reference()
    return self.ref
    }
    
    func getStorageRef() -> FIRStorageReference
    {
        self.storageRef = FIRStorage.storage().reference()
        return self.storageRef
    }
}
