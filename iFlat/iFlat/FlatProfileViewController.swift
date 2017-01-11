//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

/// This class controls flat profile view
class FlatProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ShowAlert {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    /// Outlet for UserProfileImage whose flats user
    @IBOutlet weak var wishListButton: UIButton!
    // Outlet for UserProfileImage whose flats user
    @IBOutlet weak var userProfileIV: UIImageView!
    /// Outlet for flatImages
    @IBOutlet weak var flatImagesCV: UICollectionView!
    /// Outlet for flatTitle
    @IBOutlet weak var flatTitleLb: UILabel!
    /// Outlet for flatDescription
    @IBOutlet weak var flatDesclb: UILabel!
    /// Outlet for flat capacity
    @IBOutlet weak var flatCapLb: UILabel!
    /// Outlet for bedroom quantity
    @IBOutlet weak var bedroomCLb: UILabel!
    /// Outlet for bed quantity
    @IBOutlet weak var bedCLb: UILabel!
    /// Outlet for bathroom quantity
    @IBOutlet weak var bathroomCLb: UILabel!
    /// Outlet for pool existance
    @IBOutlet weak var pool: UILabel!
    /// Outlet for internet existance
    @IBOutlet weak var internet: UILabel!
    /// Outlet for cooling existance
    @IBOutlet weak var cooling: UILabel!
    /// Outlet for heating existance
    @IBOutlet weak var heating: UILabel!
    /// Outlet for television existance
    @IBOutlet weak var television: UILabel!
    /// Outlet for washingMachine existance
    @IBOutlet weak var washingMachine: UILabel!
    /// Outlet for elevator existance
    @IBOutlet weak var elevator: UILabel!
    /// Outlet for parking existance
    @IBOutlet weak var parking: UILabel!
    /// Outlet for smoking existance
    @IBOutlet weak var smoking: UILabel!
    /// Outlet for gateKeeper existance
    @IBOutlet weak var gateKeeper: UILabel!
    /// Outlet for city of flat
    @IBOutlet weak var city: UILabel!
    /// Outlet for address of flat
    @IBOutlet weak var address: UILabel!
    /// Outlet for rating of flat
    @IBOutlet weak var rating: UILabel!
    /// Outlet for price of flat
    @IBOutlet weak var price: UILabel!
    
    /// Varible for ownerId of flat
    var ownerID:String?
    /// Varible for received flat id from ListFlat
    var receivedFlat:FilteredFlat?
    var flatEP = FIRFlat()
    var userRP = FIRUSER()
    /// Array of flat's Images
    var flatImagesArr = [FlatImageDownloaded]()
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flatImagesCell", for: indexPath) as! FlatImagesCell
        let url = URL(string:self.flatImagesArr[indexPath.row].imageDownloadURL)
        cell.FlatImage.kf.setImage(with: url)
        return cell
        
    }
    
    /// This function adds flat to whishlist
    @IBAction func addtoWish(_ sender: UIButton) {
        self.flatEP.addWishList(fltID: (self.receivedFlat?.flatID)! , completion: { (err) in
            if err == nil{
                self.showAlert(title: "Success", message: "The flat has been added to your wish list.")
                sender.isEnabled = false
            }
        })
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flatImagesArr.count
    }
    
    /// This function initialize FlatProfile
    override func viewDidLoad() {
        // This function initialize flatImages and resize user Image
        flatEP.getFlatImages(flatID: (self.receivedFlat?.flatID)!) { (images) in
            self.flatImagesArr = images!
            self.flatImagesCV.reloadData()
            self.userProfileIV.translatesAutoresizingMaskIntoConstraints = true
            
            
            
            
        }
        /// This function retrieve user Image
        userRP.getUserByID(id: ownerID!) { (usr) in
            self.userRP.getUserProfileImg(user: usr!, completion: { (url) in
                self.userProfileIV.kf.setImage(with: URL(string:url!))
            })
        }
        
        /// This function loads flat which is clicked at ListFlat, from DB
        ///
        ///
        ///  - Parameter userID: (ownerID) flat owner id
        ///  - Parameter flatID: (flatID) flat ID
        flatEP.getFlatofUser(userID: self.ownerID!, flatID: self.receivedFlat!.flatID!) { (flt) in
            self.flatTitleLb.text = flt?.title!
            self.flatDesclb.text = flt?.flatDescription!
            self.flatCapLb.text = String(describing: flt!.flatCapacity!)
            self.bedroomCLb.text = String(describing:flt!.bedroomCount!)
            self.bedroomCLb.text = String(describing:flt!.bedCount!)
            self.bathroomCLb.text = String(describing:flt!.bathroomCount!)
            self.bedCLb.text = String(describing:flt!.bedCount!)
            self.addressLbl.text = String(describing:flt!.address!)
            self.cityLbl.text = String(describing:flt!.city!)

            self.assignTrueOrFalse(sender: self.pool, what: (flt?.pool)!)
            self.assignTrueOrFalse(sender: self.internet, what: (flt?.internet)!)
            self.assignTrueOrFalse(sender: self.cooling, what: (flt?.cooling)!)
            self.assignTrueOrFalse(sender: self.heating, what: (flt?.heating)!)
            self.assignTrueOrFalse(sender: self.television, what: (flt?.tv)!)
            self.assignTrueOrFalse(sender: self.washingMachine, what: (flt?.washingMachine)!)
            self.assignTrueOrFalse(sender: self.elevator, what: (flt?.elevator)!)
            self.assignTrueOrFalse(sender: self.parking, what: (flt?.parking)!)
            self.assignTrueOrFalse(sender: self.smoking, what: (flt?.smoking)!)
            self.assignTrueOrFalse(sender: self.gateKeeper, what: (flt?.gateKeeper)!)
            
            self.cityLbl.text = flt?.city
            self.addressLbl.text = flt?.address
            
            //RATE?
            //self.assignRate(sender: self.rating, star: flt.)
            
            
        }
        
        
        
    }
    
    /// This function generates tick or cross for true or false
    func assignTrueOrFalse(sender:UILabel, what:Bool)
    {
        switch what
        {
        case true:
            sender.text = "✔︎"
            break
        case false:
            sender.text = "𐄂"
        }
    }
    /// This function generates stars for rating
    func assignRate(sender:UILabel, star:Int)
    {
        switch star
        {
        case 1:
            sender.text = "★"
            break
        case 2:
            sender.text = "★★"
        case 3:
            sender.text = "★★★"
            break
        case 4:
            sender.text = "★★★★"
            break
        case 5:
            sender.text = "★★★★★"
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is ShowUserProfileViewController){
            let segue = segue.destination as! ShowUserProfileViewController
            segue.strUserID = self.ownerID!

        }
        else{
            let segue = segue.destination as! ReservationController
            segue.flatID = receivedFlat?.flatID
            segue.ownerID = receivedFlat?.userID
        }
        
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userRP.getCurrentLoggedIn { (usr) in
            self.userRP.getWishes(usrID: (usr?.id)!, completion: { (wishes) in
                if wishes?[(self.receivedFlat?.flatID)!] != nil {
                    self.wishListButton.isEnabled = false
                }
                else{
                    self.wishListButton.isEnabled = true
                }
                
            })

            self.flatEP.getFlatsofUser(userID: (usr?.id)!, completion: { (flts) in
                
            })
            
        }
    }
    
    
    
    
}
