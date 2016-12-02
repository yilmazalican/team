//
//  UserDelegate.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

protocol FIRUSERDelegate
{
    func insert(usr:ManipulableUser, completion: () -> Void)
    func delete(usr:ManipulableUser, completion: () -> Void)
    func edit(usr:ManipulableUser, completion: () -> Void)
    func Login(usr:ManipulableUser, completion: () -> Void) -> Bool


}




class FIRUSER : FIRUSERDelegate{


    internal func Login(usr: ManipulableUser, completion: () -> Void) -> Bool {
        return true
    }

    internal func edit(usr: ManipulableUser, completion: () -> Void) {
    }

    internal func delete(usr: ManipulableUser, completion: () -> Void) {
    }

    internal func insert(usr: ManipulableUser, completion: () -> Void) {
    }
    



}
