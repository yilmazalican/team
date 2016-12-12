//
//  FIRFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 12/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import Firebase

protocol FIRFlatDelegate :class
{
    func insert(flt:ManipulableFlat!,completion: @escaping (String?) -> ())
    func edit(oldFlat:ManipulableFlat, newFlt:ManipulableFlat!, completion: @escaping (String?) -> ())
    func disable(oldUsrEmail:String, newUsr:ManipulableUser!, completion: @escaping (String?) -> ())
    func getFlat(id:String, completion: @escaping (FIRFlat?) -> ())
    func addPictures(imgs:[UIImage], completion: @escaping(String?) -> ())
    
}






class FIRFlat:FIRFlatDelegate
{


   
}
