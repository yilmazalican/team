//
//  UserDelegate.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//
//This class is wroted though FIREBASE authendication framework!
//Handle Optionals
import Foundation
import Firebase
import FirebaseStorage

///This protocol is a delegation bridge. When any coder wants to use DB manipulation methods, then the coder must use this bridge instance.
///Coder also need to conform the protocol which is ManipulableUser. If want to use the manipulation methods. Manipulation methods only takes objects which conforms ManipulableUser.
protocol FIRUSERDelegate :class
{
    func insert(usr:ManipulableUser!,completion: @escaping (String?) -> ())
    func edit(newUsr:ManipulableUser!, completion: @escaping (String?) -> ())
    func loginByEmailAndPassword(email:String, password:String, completion:  @escaping (String?) -> ())
    func logout(completion: @escaping (String?) -> ())
    func getCurrentLoggedIn(completion: @escaping (ManipulableUser?) -> ())
    func getByEmail(email:String, completion: @escaping (ManipulableUser?) -> ())
    func sendverificationEmail(completion: @escaping (String?) -> ())
    func isUserVerified(completion: @escaping (Bool) -> ())
    func changePassword(newPassword:String, completion: @escaping (String?) -> ())
    func changeEmail(newEmail:String, completion: @escaping (String?) -> ())
    func insertUserProfileImage(user:ManipulableUser, completion: @escaping (String?) -> ())
    func getUserProfileImg(user:ManipulableUser, completion: @escaping (String?) -> ())
    func rateUser(toUserID:String,rate:Rate, completion: @escaping (String?) -> ())
    func getUserRates(userID:String, completion: @escaping ([Rate]?) -> ())
    func changeUserProfileImage(user:ManipulableUser,img:UIImage, completion: @escaping (String?) -> ())
    func getCities(completion: @escaping ([String]) -> ())
    func forgotPassword(email:String, completion: @escaping (String?) -> ())
    func openIssue(toUser:ManipulableUser, issue:Issue, completion: @escaping (String?) -> ())
    func getISsue(user:ManipulableUser, completion: @escaping([Issue]) -> ())
    func getUserByID(id:String, completion: @escaping(ManipulableUser?) -> ())
    func sendReservationRequest(req:ReservationRequest, completion: @escaping(String?) -> ())
    func acceptReservationRequest(req:ReservationRequest,completion: @escaping(String?) -> ())
    func rejectReservationRequest(req:ReservationRequest,completion: @escaping(String?) -> ())
    func getFlatByID(id:String, completion: @escaping(ManipulableFlat?) -> ())
    func getUsersReservationRequests(usr:ManipulableUser, completion: @escaping([ReservationRequest]) -> ())
    func getFlatReservations(fltID:String, completion: @escaping([ReservationRequest]?) -> ())
    func getWishes(usrID:String, completion: @escaping([String:Bool]?) -> ())
    func isUserBanned(usrID:String, completion: @escaping(Bool) -> ())
    func insertObject(object:DenemeObje, completion: @escaping (String) -> ())
    func insertReservationTimeSlot(req: ReservationRequest, completion: @escaping (String?) -> ())
    func insertReservationIDToUserFlat(req:ReservationRequest, completion: @escaping (String?) -> ())
    func getRenterReservations(completion: @escaping([ReservationRequest]) -> ())
    func insertAvailableTimeSlotsToFlat(flt: ManipulableFlat, timeslot:[Int], completion: @escaping (String?) -> ()) 
    func getAvailableTimeSlotsOfFlat(userID:String,fltID:String, completion: @escaping ([Int]?) -> ())
}




/**
 This class is the object which connects coder to Db for manipulation.
 Developers can use this class at their controller classes. This class **usage** directly in model is not **allowed.**
 This class' methods only takes parameters of User,Flat and other models which conforms related protocols i.e. ManipulableUser
 */
class FIRUSER: FIRUSERDelegate {
    internal func getAvailableTimeSlotsOfFlat(userID:String, fltID: String, completion: @escaping ([Int]?) -> ()) {
        FIRREF.instance().getRef().child("user_flats/" + userID + "/" + fltID).child("available_timeslots").observeSingleEvent(of: .value, with: { (ss) in
            let val = ss.value as! [String:Bool]
            var returningDict = [Int]()
            if val.count > 0{
                for a in val{
                    if(a.value)
                    {
                        returningDict.append(Int(a.key)!)
                    }
                }
                completion(returningDict)
            }
            else{
                completion(nil)
            }
          
        })
    }




    internal func insertAvailableTimeSlotsToFlat(flt: ManipulableFlat, timeslot:[Int], completion: @escaping (String?) -> ()) {
        var timeSlotDict = [String:Bool]()
        for a in timeslot{
            timeSlotDict[String(describing:a)] = true
        }
        FIRREF.instance().getRef().child("user_flats").child(flt.userID!  + "/" + flt.id + "/" + "available_timeslots/").setValue(timeSlotDict)
        completion(nil)
    }
    
    

    internal func insertReservationIDToUserFlat(req: ReservationRequest, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("user_flats").child(req.hostUID!).child(req.flatID!).child("reservations/").child(req.id).setValue(true)
        FIRREF.instance().getRef().child("users").child(req.renterUID!).child("reservations/").child(req.id).setValue(true)
        completion(nil)
        
    }
    
    
    internal func insertReservationTimeSlot(req: ReservationRequest, completion: @escaping (String?) -> ()) {
        var dict = [String:Bool]()
        var first = req.timeSlots.first!
        let last = req.timeSlots.last!
        while(first <= last){ 
            dict[String(describing:first)] = true
            first = first + (60*60*24)
            
        }
       FIRREF.instance().getRef().child("reservationRequests/" + req.id + "/time_slots").setValue(dict) 
        completion(nil)
    }
    
    internal func insertObject(object: DenemeObje, completion: @escaping (String) -> ()) {
        FIRREF.instance().getRef().child("denemeobje").setValue(object)
        
    }
    
    internal func isUserBanned(usrID: String, completion: @escaping (Bool) -> ()) {
        let ref =  FIRDatabase.database().reference().child("users/" + usrID + "/" + "isActive")
            ref.observe(.value, with: { (ss) in
                let val = ss.value as! String
                if val == "true"
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                    ref.removeAllObservers()
                }
            })
    }
    
    /**
     This method returns its completion closure paramter, the users which have wishes. The returning wishes returns as flatID.
     - parameters:
     - usrID: The userID which is ID of user whose wishes requested.
     - completion: This parameter is a callback closure block which returns the wishes as dictionary String:Bool.
     key of the dictionary is the id of user, value is always true.
     
     */
    internal func getWishes(usrID: String, completion: @escaping ([String:Bool]?) -> ()) {
        FIRREF.instance().getRef().child("wishes/" + usrID).observeSingleEvent(of: .value, with: { (ss) in
            if ss.childrenCount == 0{
                completion(nil)
            }
            else
            {
                let value = ss.value as! [String:Bool]
                completion(value)
                
            }
        })
    }
    
    
    /**
     Get flat by its id as ManipulableFlat object
     - parameters:
     - id: The id which is ID of flat whose requested.
     - completion: This parameter is a callback closure block which returns flats as ManipulableFlat object.
     - returns:Void
     - throws:FIRERROR
     */
    internal func getFlatByID(id: String, completion: @escaping (ManipulableFlat?) -> ()) {
        FIRREF.instance().getRef().child("filter_flats/" + id).observeSingleEvent(of: .value, with: { (ss) in
            let flt = Flat()
            let objdict = ss.value as! [String:Any]
            flt.bathroomCount = objdict["bathroomCount"] as? Int
            flt.bedCount = objdict["bedCount"] as? Int
            flt.cooling = objdict["cooling"] as? Bool
            flt.bedroomCount = objdict["bedroomCount"] as? Int
            flt.internet = objdict["internet"] as? Bool
            flt.elevator = objdict["elevator"] as? Bool
            flt.flatDescription = objdict["description"] as? String
            flt.heating = objdict["heating"] as? Bool
            flt.gateKeeper = objdict["gateKeeper"] as? Bool
            flt.parking = objdict["parking"] as? Bool
            flt.pool = objdict["pool"] as? Bool
            flt.smoking = objdict["smoking"] as? Bool
            flt.price = objdict["price"] as? Double
            flt.tv = objdict["tv"] as? Bool
            flt.washingMachine = objdict["washingMachine"] as? Bool
            flt.flatCapacity = objdict["capacity"] as? Int
            flt.title = objdict["title"] as? String
            flt.address = objdict["adress"] as? String
            flt.id = ss.key
            flt.userID = (objdict["userId"] as? String)!
            flt.disabled = objdict["disabled"] as? Bool
            flt.published = objdict["published"] as? Bool
            completion(flt)
        })
    }
    
    /// This functions loads logged user's reservation request
    ///
    ///  - Parameter usr: (ManipubleUser)
    ///  - Parameter completion: Completion Block
    ///  - throws: FIRERROR?
    ///  - returns void
    internal func getUsersReservationRequests(usr:ManipulableUser,completion: @escaping([ReservationRequest]) -> ()) {
        var returningReqs = [ReservationRequest]()
        FIRREF.instance().getRef().child("reservationRequests").queryOrdered(byChild: "hostUID").queryEqual(toValue: usr.id).observeSingleEvent(of: .value, with: { (ss) in
            let obj = ss.children.allObjects
            for a in obj
            {
                let key = a as! FIRDataSnapshot
                let value = key.value as! [String:Any]
                let req = ReservationRequest()
                req.accepted = Int(value["status"] as! String)
                req.date = value["date"] as? String
                req.flatID = value["flatID"] as? String
                req.id = key.key
                req.renterUID = value["renterUID"] as? String
                req.hostUID = value["hostUID"] as? String
                req.timeSlots = (value["time_slots"] as? [Int])!
                returningReqs.append(req)
            }
            completion(returningReqs)
        })
        
    }
    
    
    internal func getFlatReservations(fltID : String, completion : @escaping([ReservationRequest]?) -> ()){
        var allReserv = [ReservationRequest]()
        getCurrentLoggedIn { (usr) in
            FIRREF.instance().getRef().child("user_flats/" + usr!.id! + "/" + fltID + "/" + "reservations").observeSingleEvent(of: .value, with: { (ss) in
                if ss.childrenCount > 0{
                    let obj = ss.value as! [String:Bool]
                    
                    for (index,a) in obj.enumerated(){
                        let reserv = ReservationRequest()
                        FIRREF.instance().getRef().child("reservationRequests/" + a.key).observeSingleEvent(of: .value, with: { (ss) in
                            let value = ss.value as! [String:Any]
                            reserv.accepted = value["status"] as? Int
                            reserv.date = value["date"] as! String?
                            reserv.flatID = value["flatID"] as! String?
                            reserv.hostUID = value["hostUID"] as! String?
                            reserv.renterUID = value["renterUID"] as? String
                            reserv.id = ss.key
                            let b = value["time_slots"] as! [String:Bool]
                            for c in b{
                                reserv.timeSlots.append(Int(c.key)!)
                            }
                            allReserv.append(reserv)
                            if index == obj.count - 1 {
                                completion(allReserv)

                            }
                        })
                    }
                    
                }
                else{
                    completion(nil)
                }
                

            })
        }
    }
    
    internal func getRenterReservations(completion : @escaping([ReservationRequest]) -> ()){
        var allReserv = [ReservationRequest]()
        getCurrentLoggedIn { (usr) in
            FIRREF.instance().getRef().child("users/" + usr!.id! + "/" + "reservations").observeSingleEvent(of: .value, with: { (ss) in
                let obj = ss.value as! [String:Bool]
                
                for a in obj{
                    let reserv = ReservationRequest()
                    FIRREF.instance().getRef().child("reservationRequests/" + a.key).observeSingleEvent(of: .value, with: { (ss) in
                        let value = ss.value as! [String:Any]
                        reserv.accepted = value["status"] as? Int
                        reserv.date = value["date"] as! String!
                        reserv.flatID = value["flatID"] as! String!
                        reserv.hostUID = value["hostUID"] as! String!
                        reserv.renterUID = value["renterUID"] as? String
                        reserv.id = ss.key
                        let b = value["time_slots"] as! [Int:Bool]
                        for c in b{
                            reserv.timeSlots.append(c.key)
                        }
                        allReserv.append(reserv)
                    })
                }
                completion(allReserv)
            })
        }
    }
    
    /// This function makes reservation request accepted
    ///
    ///  - Parameter req: (ReservationRequest)
    ///  - Parameter completion: Completion Block
    ///  - throws: FIRERRIR
    ///  - returns: void
    internal func acceptReservationRequest(req: ReservationRequest, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("reservationRequests/" + req.id).setValue(1, forKey: "accepted")
    }
    
    /// This function rejects reservation request
    ///
    ///  - Parameter req: (ReservationRequest)
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func rejectReservationRequest(req: ReservationRequest, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("reservationRequests/" + req.id).setValue(2, forKey: "accepted")
    }
    
    /// This function adds reservation request to DB
    ///
    ///  - Parameter req: (ReservationRequest)
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func sendReservationRequest(req: ReservationRequest, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("reservationRequests/" + req.id).setValue(
            [
                "renterUID": req.renterUID! as String,
                "hostUID": req.hostUID! as String,
                "flatID" : req.flatID!,
                "status": req.accepted!,
                "date": req.date!
            ]
            
        ) { (err, nil) in
            if err == nil
            {
                self.insertReservationTimeSlot(req: req, completion: { (str) in
                    if str == nil{
                        self.insertReservationIDToUserFlat(req: req, completion: { (err) in
                            if err == nil{
                                completion(nil)
                            }
                        }) 
                    }
                    
                })
            }
            else
            {
                completion(err.debugDescription)
            }
        }
    }
    
    
    
    /// This functions gets user from DB with userID
    ///
    ///  - Parameter id: (String) UserID
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getUserByID(id: String, completion: @escaping (ManipulableUser?) -> ()) {
        let usr = User()
        
        FIRREF.instance().getRef().child("users/" + id).observeSingleEvent(of: .value, with: { snapshot in
            
            if(snapshot.childrenCount >= 1){
                
                let objdict = snapshot.value as! [String:Any]
                usr.id = snapshot.key
                usr.email = objdict["email"] as! String!
                usr.Gender = objdict["gender"] as! String!
                usr.name = objdict["firstName"] as! String!
                usr.birthDate = objdict["birthdate"] as! String!
                usr.surname = objdict["lastName"] as! String!
                usr.country = objdict["country"] as! String!
                completion(usr)
            }
            else
            {
                completion(nil)
            }
        })
    }
    
    
    /// This function opens issue to specific user.
    ///
    ///  - Parameter toUser: (ManipulableUser) User
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func openIssue(toUser: ManipulableUser, issue: Issue, completion: @escaping (String?) -> ()) {
        let insertingDict = [
            "content": issue.content!,
            "isOpen": issue.isOpen!,
            "issued": toUser.id!,
            "title": issue.title!,
            "issuer": issue.issuer!] as [String : Any]
        
        FIRREF.instance().getRef().child("issues/"  + issue.ID!).setValue(insertingDict) { (err, nil) in
            
            if err == nil
            {
                completion(nil)
            }
            else
            {
                completion(err.debugDescription)
            }
        }
    }
    
    /// This function gets issue of user.
    ///
    ///  - Parameter user: (ManipulableUser) User object
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getISsue(user: ManipulableUser, completion: @escaping ([Issue]) -> ()) {
        var issues = [Issue]()
        FIRREF.instance().getRef().child("issues").queryOrdered(byChild: "issuer").queryEqual(toValue: user.id).observeSingleEvent(of: .value, with: { (ss) in
            let obj = ss.children.allObjects
            for a in obj
            {
                let key = a as! FIRDataSnapshot
                let value = key.value as! [String:Any]
                
                let title = value["title"] as! String
                let content = value["content"] as! String
                let issued = value["issued"] as! String
                let isOpen = value["isOpen"] as! String
                let answer = value["answer"] as? String
                let issue = Issue(title: title, content: content, issued: issued)
                issue.ID = key.key
                issue.issuer = value["issuer"] as? String
                issue.isOpen = isOpen
                issue.answer = answer
                issues.append(issue)
                
            }
            completion(issues)
        })
    }
    
    
    
    /// This function sends password reset email to user
    ///
    ///  - Parameter email: (String) UserEmail
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func forgotPassword(email: String, completion: @escaping (String?) -> ()) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (err) in
            if err != nil
            {
                completion(err.debugDescription)
                return
            }
            else
            {
                completion(nil)
                return
            }
        })
    }
    /// This function gets cities from the db.
    ///
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getCities(completion: @escaping ([String]) -> ()) {
        FIRREF.instance().getRef().child("cities").queryOrderedByKey().observeSingleEvent(of: .value, with: { (ss) in
            var arr = [String]()
            let dict = ss.value as! [String]
            for a in dict
            {
                arr.append(a)
            }
            let sortedArr = arr.sorted(by: { $0 < $1  })
            completion(sortedArr)
            
        })
    }
    
    
    /// This function changes user's profile Image
    ///
    ///  - Parameter user: (ManipubleUser) that currently logged
    ///  - Parameter img: (UIImage) new profile image
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func changeUserProfileImage(user: ManipulableUser, img: UIImage, completion: @escaping (String?) -> ()) {
        user.profileImage = img
        insertUserProfileImage(user: user) { (str) in
            completion(str)
        }
    }
    
    
    
    
    
    
    /// This function retrieves rates of User from DB
    ///
    ///  - Parameter userID: (String) User ID of requesting one
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getUserRates(userID: String, completion: @escaping ([Rate]?) -> ()) {
        var allRates = [Rate]()
        FIRREF.instance().getRef().child("user_rates/" + userID).observeSingleEvent(of: .value, with:  { (ss) in
            let allvalues = ss.children.allObjects
            for a in allvalues
            {
                let keyObj = a as! FIRDataSnapshot
                let obj = keyObj.value as! [String:Any]
                let rate = Rate()
                rate.rateID = keyObj.key
                rate.rate = obj["rate"] as! Int?
                rate.from_userID = obj["from"] as! String?
                allRates.append(rate)
            }
            completion(allRates)
            
        })
        
    }
    /// This function adds rate to user
    ///
    ///  - Parameter toUserID: (String) User ID of rating user
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func rateUser(toUserID:String, rate: Rate, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("user_rates/" + toUserID + "/" + rate.rateID!).setValue(["from" : rate.from_userID!, "rate": rate.rate!]) { (err, nil) in
            if err == nil
            {
                completion(nil)
            }
            else
            {
                completion(err.debugDescription)
                return
            }
        }
        
        
    }
    
    /// This function retrieves user's profile image's URL
    ///
    ///  - Parameter user: ManipubleUSer
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getUserProfileImg(user: ManipulableUser, completion: @escaping (String?) -> ()) {
        FIRREF.instance().getRef().child("user_profile_images/" + user.id!).observeSingleEvent(of: .value, with: { (ss) in
            let dict = ss.value as! [String:String]
            completion(dict["downloadURL"])
        })
    }
    
    
    
    /// This fuction inserts User Profile Image to storage and DB
    ///
    ///  - Parameter user: ManipubleUser
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func insertUserProfileImage(user: ManipulableUser, completion: @escaping (String?) -> ()) {
        if let profileImg = user.profileImage
        {
            let imagePNGDataConverter = UIImageJPEGRepresentation(profileImg, 0.1)
            
            FIRREF.instance().getStorageRef().child("user_profile_images/" + user.id! + ".jpeg").put(imagePNGDataConverter!, metadata: nil) { (metadata, error) in
                if (error == nil)
                {
                    FIRREF.instance().getRef().child("user_profile_images/" + user.id!).setValue(
                        ["downloadURL" : metadata?.downloadURL()?.absoluteString]
                        ,withCompletionBlock: { (err, nil) in
                            if err == nil{
                                completion(nil)
                            }
                            else
                            {
                                completion(err.debugDescription)
                                return
                            }
                    })
                }
            }
        }
        else
        {
            completion("user profile image is nil!")
            return
        }
    }
    
    
    
    
    
    
    /// This function changes Email of user
    ///
    ///  - Parameter newEmail: UserEmail
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func changeEmail(newEmail: String, completion: @escaping (String?) -> ()) {
        
        
        
        FIRAuth.auth()?.currentUser?.updateEmail(newEmail, completion: { (err) in
            if err == nil{
                
                completion(nil)
            }
            else
            {
                completion(err.debugDescription)
                return
            }
        })
    }
    
    /// This function changes password of user
    ///
    ///  - Parameter newPassword: UserEmail
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func changePassword(newPassword:String,completion: @escaping (String?) -> ()) {
        FIRAuth.auth()?.currentUser?.updatePassword(newPassword, completion: { (err) in
            if err == nil
            {
                completion(nil)
            }
            else{
                completion(err.debugDescription)
                return
            }
        })
    }
    
    /// This function checks is user verified
    ///
    ///  - Parameter completion: Completion Block
    ///  - returns void
    ///  - throws: FIRERROR
    internal func isUserVerified(completion: @escaping (Bool) -> ()) {
        let isVerified = FIRAuth.auth()?.currentUser?.isEmailVerified
        completion(isVerified!)
    }
    
    /// That function sends verification email to user
    ///
    ///  - Parameter completion: Completion Block that gets String
    ///  - Returns: Void
    ///  - returns void
    ///  - throws: FIRERROR
    internal func sendverificationEmail(completion: @escaping (String?) -> ()) {
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (e) in
            if e == nil
            {
                completion(nil)
            }
            else
            {
                completion(e.debugDescription)
                
            }
        })
    }
    
    ///Returns a Manipulableuser Instance for a given email. If email exists in DB.
    ///If the user exists, returns it. Otherwise, returns nil.
    ///Returning parameters are in completion block.
    ///
    ///  - Parameter email: UserEmail
    ///  - Parameter completion: Completion Block that gets ManipubleUser
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getByEmail(email: String, completion: @escaping (ManipulableUser?) -> ()) {
        let usr = User()
        
        FIRREF.instance().getRef().child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value, with: { snapshot in
            
            if(snapshot.childrenCount >= 1){
                let obj = snapshot.children.allObjects[0] as! FIRDataSnapshot
                let objdict = obj.value as! [String:Any]
                usr.id = obj.key
                usr.email = objdict["email"] as! String!
                usr.Gender = objdict["gender"] as! String!
                usr.birthDate = objdict["birthdate"] as! String!
                usr.surname = objdict["lastName"] as! String!
                usr.name = objdict["firstName"] as! String!
                usr.country = objdict["country"] as! String!
                
                
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
    ///
    ///  - Parameter completion: Completion Block that gets ManipubleUser
    ///  - returns void
    ///  - throws: FIRERROR
    internal func getCurrentLoggedIn(completion:  @escaping (ManipulableUser?) -> ()) {
        if let loggedUsr = FIRAuth.auth()?.currentUser{
            getByEmail(email: loggedUsr.email!, completion: { (usr) in
                completion(usr)
            })
        }
        else
        {
            completion(nil)
            
        }
    }
    
    ///Logouts user who is logged in already.
    ///If the user exists, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    ///
    ///  - Parameter completion: Completion Block that gets String
    internal func logout(completion:  @escaping (String?) -> ()) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            completion("ERROR OCCURED DURING SIGN OUT!")
        }
        completion(nil)
        
        return
        
    }
    
    ///Logouts user who is logged in already.
    ///If the user exists, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    ///
    ///  - Parameter email: UserEmail
    ///  - Parameter password: USerPassword
    ///  - Parameter completion: Completion Block that gets String
    internal func loginByEmailAndPassword(email: String, password: String, completion:  @escaping (String?) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            if err != nil{
                completion(err.debugDescription)
                return
                
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
    ///
    ///  - Parameter newUsr: ManipubleUser object that edited
    ///  - Parameter completion: Completion Block that gets String
    ///  - returns void
    ///  - throws: FIRERROR
    internal func edit(newUsr: ManipulableUser!, completion:  @escaping (String?) -> ()) {
        getCurrentLoggedIn { (loggedUser) in
            if loggedUser != nil
            {
                FIRREF.instance().getRef().child("users").child((loggedUser?.id!)!).setValue(
                    [
                        "firstName": newUsr.name!,
                        "lastName" : newUsr.surname!,
                        "birthdate": newUsr.birthDate!,
                        "country": newUsr.country!,
                        "email": newUsr.email!,
                        "gender": newUsr.Gender!,
                        "isActive": "true"
                    ]
                )
                self.changeEmail(newEmail: newUsr.email!, completion: { (str) in
                    if str != nil
                    {
                        completion(str)
                    }
                    else
                    {
                        completion(str)
                    }
                })
                
            }
            else
            {
                completion("No logged in user detected!")
            }
        }
        
        
        
        
        
    }
    ///Insert user which is manipulableuser.
    ///If the operation is OK, returns true. Otherwise, returns false.
    ///Returning parameters are in completion block.
    ///This func also adds id to the inserted user object.
    ///
    ///  - Parameter usr: New Manipuble User
    ///  - Parameter completion: Completion Block that get String
    ///  - returns void
    ///  - throws: FIRERROR
    internal func insert( usr: ManipulableUser!, completion: @escaping (String?) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: usr.email!, password: usr.password!, completion: { (user, err) in
            if err == nil
            {
                FIRREF.instance().getRef().child("users").child(user!.uid).setValue(
                    [
                        "firstName": usr.name!,
                        "lastName" : usr.surname!,
                        "email": usr.email!,
                        "gender": usr.Gender!,
                        "birthdate": usr.birthDate!,
                        "country": usr.country!,
                        "isActive": "true"
                    ],
                    withCompletionBlock: { (err, ref) in
                        if err == nil{
                            usr.id = user?.uid
                            completion(nil)
                        }
                            
                        else
                        {
                            completion(err?.localizedDescription)
                            return
                        }
                })
                
            }
            else {
                completion(err?.localizedDescription)
                return
            }
        })
        
    }
}


