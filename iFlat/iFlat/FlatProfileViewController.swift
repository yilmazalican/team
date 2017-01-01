//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var userProfileIV: UIImageView!
    @IBOutlet weak var flatImagesCV: UICollectionView!
    
    @IBOutlet weak var flatTitleLb: UILabel!
    @IBOutlet weak var flatDesclb: UILabel!
    @IBOutlet weak var flatCapLb: UILabel!
    @IBOutlet weak var bedroomCLb: UILabel!
    @IBOutlet weak var bedCLb: UILabel!
    @IBOutlet weak var bathroomCLb: UILabel!
    
    @IBOutlet weak var pool: UILabel!
    @IBOutlet weak var internet: UILabel!
    @IBOutlet weak var cooling: UILabel!
    @IBOutlet weak var heating: UILabel!
    @IBOutlet weak var television: UILabel!
    @IBOutlet weak var washingMachine: UILabel!
    @IBOutlet weak var elevator: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet weak var smoking: UILabel!
    @IBOutlet weak var gateKeeper: UILabel!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var ownerID:String?
    var receivedFlat:FilteredFlat?
    var flatEP = FIRFlat()
    var userRP = FIRUSER()
    var flatImagesArr = [FlatImageDownloaded]()
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flatImagesCell", for: indexPath) as! FlatImagesCell
        let url = URL(string:self.flatImagesArr[indexPath.row].imageDownloadURL)
        cell.FlatImage.kf.setImage(with: url)
        return cell
        
    }

    @IBAction func addtoWish(_ sender: UIButton) {
        self.flatEP.getFlatofUser(userID: self.receivedFlat!.userID!, flatID: self.receivedFlat!.flatID!) { (flt) in
            self.flatEP.addWishList(flt: flt!) { (err) in
        }
        
        }
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flatImagesArr.count
    }
    
    override func viewDidLoad() {
        flatEP.getFlatImages(flatID: (self.receivedFlat?.flatID)!) { (images) in
            self.flatImagesArr = images!
            self.flatImagesCV.reloadData()
            self.userProfileIV.translatesAutoresizingMaskIntoConstraints = true
            
            


        }
        
        userRP.getCurrentLoggedIn { (usr) in
            self.userRP.getUserProfileImg(user: usr!, completion: { (img) in
                let url = URL(string:img!)
                self.userProfileIV.kf.setImage(with: url)

            })
        }
        
        flatEP.getFlatofUser(userID: self.ownerID!, flatID: self.receivedFlat!.flatID!) { (flt) in
            self.flatTitleLb.text = flt?.title!
            self.flatDesclb.text = flt?.flatDescription!
            self.flatCapLb.text = String(describing: flt!.flatCapacity!)
            self.bedroomCLb.text = String(describing:flt!.bedroomCount!)
            self.bedroomCLb.text = String(describing:flt!.bedCount!)
            self.bathroomCLb.text = String(describing:flt!.bathroomCount!)

            self.assignTrueOrFalse(sender: self.pool, what: (flt?.pool)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.internet)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.cooling)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.heating)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.tv)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.washingMachine)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.elevator)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.parking)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.smoking)!)
            self.assignTrueOrFalse(sender: self.pool, what: (flt?.gateKeeper)!)

            self.city.text = flt?.city
            self.address.text = flt?.address
            
            //RATE?
            //self.assignRate(sender: self.rating, star: flt.)
            
            
        }
        
        
        
    }

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

    
    


}
