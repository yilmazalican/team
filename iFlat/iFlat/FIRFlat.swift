//
//  FIRFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 12/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import Firebase
// deletepicture yap!
protocol FIRFlatDelegate :class
{
    func edit(newFlt:ManipulableFlat!, completion: @escaping (String?) -> ())
    func disable(disablingFlat:ManipulableFlat!, completion: @escaping (String?) -> ())
    func getFlat(id:String, completion: @escaping (ManipulableFlat?) -> ())
    func addPictures(imgs:[UIImage], completion: @escaping(String?) -> ())
    func addPicture(img:UIImage, completion: @escaping(String?) -> ())
    func deletePicture()
    func getFlatsofUser(userID:String, completion: @escaping ([ManipulableFlat]?) -> ())

    
}



class FIRFlat:FIRFlatDelegate
{
    internal func getFlatsofUser(userID: String, completion: @escaping ([ManipulableFlat]?) -> ()) {
       
        FIRREF.instance.getRef().child("user_flats/" + userID).observe(.value, with: { (ss) in
           
            
        })

    }

    
    internal func disable(disablingFlat: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let currentUsrID = FIRAuth.auth()?.currentUser?.uid
        FIRREF.instance.getRef().child("allflat/" +  disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance.getRef().child("user_flats/" + currentUsrID! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")
        FIRREF.instance.getRef().child("filter_flats/" + disablingFlat.city! + "/" + disablingFlat.id).setValue(true, forKey: "disabled")
    }

   
    internal func edit(newFlt: ManipulableFlat!, completion: @escaping (String?) -> ()) {
        let db_endpoint = FIRUSER()
                db_endpoint.insertFlat(flt: newFlt, completion: { (str) in
                    completion(str)
                })
        }
        
        
    


    internal func deletePicture() {
        
    }
    
    internal func addPicture(img: UIImage, completion: @escaping (String?) -> ()) {
        
    }
    
    internal func addPictures(imgs: [UIImage], completion: @escaping (String?) -> ()) {
        
    }
    // getflats?
    internal func getFlat(id: String, completion: @escaping (ManipulableFlat?) -> ()) {
        
        FIRREF.instance.getRef().child("allflats/" + id).observeSingleEvent(of: .value, with: { (snapshot) in
            let returningFlat = Flat()
            let objdict = snapshot.value as! [String:Any]
            returningFlat.bathroomCount = objdict["bathroomCount"] as? Int
            returningFlat.bedCount = objdict["bedCount"] as? Int
            returningFlat.cooling = objdict["cooling"] as? Bool
            returningFlat.bedroomCount = objdict["bedroomCount"] as? Int
            returningFlat.internet = objdict["internet"] as? Bool
            returningFlat.elevator = objdict["elevator"] as? Bool
            returningFlat.flatDescription = objdict["description"] as? String
            returningFlat.heating = objdict["heating"] as? Bool
            returningFlat.gateKeeper = objdict["gateKeeper"] as? Bool
            returningFlat.parking = objdict["parking"] as? Bool
            returningFlat.pool = objdict["pool"] as? Bool
            returningFlat.smoking = objdict["smoking"] as? Bool
            returningFlat.price = objdict["price"] as? Int
            returningFlat.tv = objdict["tv"] as? Bool
            returningFlat.washingMachine = objdict["washingMachine"] as? Bool
            returningFlat.flatCapacity = objdict["capacity"] as? Int
            returningFlat.title = objdict["title"] as? String
            completion(returningFlat)
        })
        
        }
    
    }








