//
//  UserDelegate.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//
//change password and change email not included.

import Foundation
import Firebase

protocol FIRUSERDelegate :class
{
    func insert(usr:ManipulableUser!,completion: @escaping (Bool) -> ())
    func edit(oldUsrEmail:String, newUsr:ManipulableUser!, completion: @escaping (Bool) -> ())
    func loginByEmailAndPassword(email:String, password:String, completion:  @escaping (Bool) -> ())
    func logout(completion: @escaping (Bool) -> ())
    func getCurrentLoggedIn(completion: @escaping (ManipulableUser?) -> ())
    func getByEmail(email:String, completion: @escaping (ManipulableUser?) -> ())
}


class FIRUSER: FIRUSERDelegate{
    
    internal func getByEmail(email: String, completion: @escaping (ManipulableUser?) -> ()) {
        let usr = User()
        FIRREF.instance.getRef().child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value, with: { snapshot in
            
            if(snapshot.childrenCount >= 1){
                let obj = snapshot.children.allObjects[0] as! FIRDataSnapshot
                let objdict = obj.value as! [String:String]
                usr.id = obj.key
                usr.email = objdict["email"]
                usr.Gender = objdict["gender"]
                usr.name = objdict["firstName"]
                usr.birthDate = objdict["birthdate"]
                usr.surname = objdict["lastName"]
                completion(usr)
            }
            else
            {
                completion(nil)
            }
        })
    }
    
    internal func getCurrentLoggedIn(completion:  @escaping (ManipulableUser?) -> ()) {
        if let loggedUsr = FIRAuth.auth()?.currentUser{
            getByEmail(email: loggedUsr.email!, completion: { (usr) in
                completion(usr)
            })
        }
        completion(nil)
    }
    
    internal func logout(completion:  @escaping (Bool) -> ()) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            completion(false)
        }
        completion(true)

    }
    
    internal func loginByEmailAndPassword(email: String, password: String, completion:  @escaping (Bool) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            if err != nil{
                completion(false)
            }
            completion(true)
        })
    }
    
    internal func edit(oldUsrEmail:String, newUsr: ManipulableUser!, completion:  @escaping (Bool) -> ()) {
        
        getByEmail(email: oldUsrEmail) { (usr) in
            if let user = usr{
                FIRREF.instance.getRef().child("users").child(user.id!).setValue(
                    [
                        "firstName": newUsr.name!,
                        "lastName" : newUsr.surname!,
                        "email": newUsr.email!,
                        "gender": newUsr.Gender!,
                        "birthdate": newUsr.birthDate!
                    ]
                )
                completion(true)
            }
            completion(false)

        }
    }
    
    internal func insert( usr: ManipulableUser!, completion: @escaping (Bool) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: usr.email!, password: usr.password!, completion: { (user, err) in
            if err == nil
            {
               
                FIRREF.instance.getRef().child("users").child(user!.uid).setValue(
                    [
                    "firstName": usr.name,
                    "lastName" : usr.surname!,
                    "email": usr.email!,
                    "gender": usr.Gender!,
                    "birthdate": usr.birthDate
                    ],
                    withCompletionBlock: { (err, ref) in
                        if err == nil{
                            usr.id = user?.uid
                            completion(true)
                        }
                        else
                        {
                            completion(false)
                        }
                })

            }
        })

    }
    
    
    
    
}

