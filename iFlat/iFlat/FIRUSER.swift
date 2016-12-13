//
//  UserDelegate.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//
//Change password and change email not included.
//This class is wroted though FIREBASE user authendication framework!
//Handle Optionals
import Foundation
import Firebase

///This protocol is a delegation bridge. When any coder wants to use DB manipulation methods, then the coder must use this bridge instance.
///Coder also need to conform the protocol which is ManipulableUser. If want to use the manipulation methods. Manipulation methods only takes objects which conforms ManipulableUser.
protocol FIRUSERDelegate :class
{
    func insert(usr:ManipulableUser!,completion: @escaping (Bool) -> ())
    func edit(oldUsrEmail:String, newUsr:ManipulableUser!, completion: @escaping (Bool) -> ())
    func loginByEmailAndPassword(email:String, password:String, completion:  @escaping (String?) -> ())
    func logout(completion: @escaping (Bool) -> ())
    func getCurrentLoggedIn(completion: @escaping (ManipulableUser?) -> ())
    func getByEmail(email:String, completion: @escaping (ManipulableUser?) -> ())
    func sendverificationEmail(completion: @escaping (Bool) -> ())
    func isUserVerified(completion: @escaping (Bool) -> ())
    func changePassword(newPassword:String, completion: @escaping (Bool) -> ())
    func changeEmail(newEmail:String, completion: @escaping (Bool) -> ())
    func insertFlat(flt:ManipulableFlat, completion: @escaping(String?) -> ())

}



///This class is the object which connects coder to Db for manipulation.
class FIRUSER: FIRUSERDelegate {
    let currentLoggedUserID = FIRAuth.auth()?.currentUser?.uid
    internal func insertFlat(flt: ManipulableFlat, completion: @escaping (String?) -> ()) {
        let aFlat = [
                     "bathroomCount": flt.bathroomCount!,
                     "bedCount" : flt.bedCount!,
                     "cooling" : flt.cooling!,
                     "bedroomCount" : flt.bedroomCount!,
                     "internet" : flt.internet!,
                     "elevator" : flt.elevator!,
                     "description" : flt.flatDescription!,
                     "heating" : flt.heating!,
                     "gateKeeper" : flt.gateKeeper!,
                     "parking" : flt.parking!,
                     "pool" : flt.pool!,
                     "smoking" : flt.smoking!,
                     "price" : flt.price!,
                     "tv" : flt.tv!,
                     "washingMachine" : flt.washingMachine!,
                     "capacity" : flt.flatCapacity!,
                     "title" : flt.title!] as [String : Any]
       
        //Allflats
        FIRREF.instance.getRef().child("allflats").child(flt.id).setValue(aFlat) { (err1, nil) in
            //user_flats
            FIRREF.instance.getRef().child("user_flats/" + self.currentLoggedUserID!).child(flt.id).setValue(aFlat) { (err2, nil) in
                //filter_flats
                FIRREF.instance.getRef().child("filter_flats/" + flt.city!).child(flt.id).setValue(aFlat) { (err3, nil) in
                if (err1 == nil || err2 == nil || err3 == nil)
                {
                    completion(nil)
                }
                    else
                {
                    completion(err1.debugDescription + err2.debugDescription + err3.debugDescription)
                }
            }

        }
        
    }
    }

    
    
    internal func changeEmail(newEmail: String, completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.currentUser?.updateEmail(newEmail, completion: { (err) in
            if err == nil{
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }

    internal func changePassword(newPassword:String,completion: @escaping (Bool) -> ()) {
            FIRAuth.auth()?.currentUser?.updatePassword(newPassword, completion: { (err) in
                if err == nil
                {
                    completion(true)
                }
                else{
                completion(false)
                }
            })
         }

    internal func isUserVerified(completion: @escaping (Bool) -> ()) {
            let isVerified = FIRAuth.auth()?.currentUser?.isEmailVerified
            completion(isVerified!)
    }

    internal func sendverificationEmail(completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (e) in
            if e == nil
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        })
    }

    ///Returns a Manipulableuser Instance for a given email. If email exists in DB.
    ///If the user exists, returns it. Otherwise, returns nil.
    ///Returning parameters are in completion block.
    internal func getByEmail(email: String, completion: @escaping (ManipulableUser?) -> ()) {
        let usr = User()
        FIRREF.instance.getRef().child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value, with: { snapshot in
            
            if(snapshot.childrenCount >= 1){
                let obj = snapshot.children.allObjects[0] as! FIRDataSnapshot
                let objdict = obj.value as! [String:String]
                usr.id = obj.key
                usr.email = objdict["email"]!
                usr.Gender = objdict["gender"]!
                usr.name = objdict["firstName"]!
                usr.birthDate = objdict["birthdate"]!
                usr.surname = objdict["lastName"]!
                completion(usr)
            }
            else
            {
                completion(nil)
            }
        })
    }

    ///Returns currently logged user if any.
    ///If the user exists, returns it. Otherwise, returns nil.
    ///Returning parameters are in completion block.
    internal func getCurrentLoggedIn(completion:  @escaping (ManipulableUser?) -> ()) {
        if let loggedUsr = FIRAuth.auth()?.currentUser{
            getByEmail(email: loggedUsr.email!, completion: { (usr) in
                completion(usr)
            })
        }
        completion(nil)
    }
    
    ///Logouts user who is logged in already.
    ///If the user exists, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    internal func logout(completion:  @escaping (Bool) -> ()) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            completion(false)
        }
        completion(true)

    }
    
    ///Logouts user who is logged in already.
    ///If the user exists, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    internal func loginByEmailAndPassword(email: String, password: String, completion:  @escaping (String?) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            if err != nil{
                completion(err.debugDescription)
                print(err.debugDescription)

            }
            else
            {
                completion(nil)
            }
        })
    }
    ///Edit user info. The parameter newUsr is the new user whos info will replaced by the user which is passed by its email.
    ///If the user exists, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    internal func edit(oldUsrEmail:String, newUsr: ManipulableUser!, completion:  @escaping (Bool) -> ()) {
        
        getByEmail(email: oldUsrEmail) { (usr) in
            if let user = usr{
                FIRREF.instance.getRef().child("users").child(user.id!).setValue(
                    [
                        "firstName": newUsr.name!,
                        "lastName" : newUsr.surname!,
                        "email": newUsr.email!,
                        "gender": newUsr.Gender!,
                        "birthdate": newUsr.birthDate!	                    ]
                )
                completion(true)
            }
            completion(false)
        }
    }
    ///Insert user which is manipulableuser.
    ///If the operation is OK, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    ///This func also adds id to the inserted user object.
    internal func insert( usr: ManipulableUser!, completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: usr.email!, password: usr.password!, completion: { (user, err) in
            if err == nil
            {
                FIRREF.instance.getRef().child("users").child(user!.uid).setValue(
                    [
                    "firstName": usr.name!,
                    "lastName" : usr.surname!,
                    "email": usr.email!,
                    "gender": usr.Gender!,
                    "birthdate": usr.birthDate!
                    ],
                    withCompletionBlock: { (err, ref) in
                        if err == nil{
                            usr.id = user?.uid
                            self.logout(completion: { (c) in
                                completion(true)
                            })
                        }
                            
                        else
                        {
                            completion(false)
                        }
                })

            }
            else {
                completion(false)
            }
        })

    }
    
    
    
    
    
    
}

