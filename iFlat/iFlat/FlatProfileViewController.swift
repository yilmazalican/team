//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

// That class controls FlatProfile View
class FlatProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

//burada eksik var/time fault
    var receivedFlatID: String = ""
    var flat : Flat!
    var ownerID : String = ""
    var returnedImagesURLs : [FlatImageDownloaded]?
    
    @IBOutlet var flatImages: UIImageView!
    //@IBOutlet var flatRating: UILabel!
    @IBOutlet var flatRatingTV: UILabel!
    @IBOutlet var flatSpecsTV: UILabel!
    @IBOutlet var flatPriceTV: UILabel!
    @IBOutlet var flatDetailsTV: UILabel!
    @IBOutlet var flatOwnerTV: UILabel!
    @IBOutlet var flatTitleTV: UILabel!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // flat will filled by segue. !!! FIX IT !!!
    initFlat { (flt) in
        self.flat = flt
        self.flat.DB_ENDPOINT.getFlatImages(flatID: flt.id, completion: { (returnedImages) in
           
                self.returnedImagesURLs = returnedImages
            
            self.initGui()
        })
        
        }
        
        
    }
    
    
    
    func initFlat(completion: @escaping (Flat)-> ()){
        
        flat = Flat()
        flat.DB_ENDPOINT.getFlatofUser(userID: ownerID, flatID: receivedFlatID) { (flat) in
            completion(flat as! Flat)
            
            
        }
        
    }
    
    /** This is an initializer function that initialize Gui (fills the views of flat variables)
     
     - parameters:  No parameter
     - returns:     void
     - throws:      Nothing
     */
    func initGui(){
        // check string casting
        self.flatPriceTV.text = String(describing: (flat.price)!)
        self.flatDetailsTV.text = (flat.flatDescription)!
        self.flatOwnerTV.text = flat.userID
        //self.flatTitleTV.text = (flat.title)!
        self.flatTitleTV.text = (receivedFlatID)
        self.flatSpecsTV.text = "Bathroom:" + String(describing: (flat.bathroomCount)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /** This function returns flat image quantity to collection view (flatImage quantity is constant, 5) which is delegate function of Collection View
     
     - returns: int (5)
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    /** This function returns image container cell to collection view which is delegate function of Collection View
     
     - returns: FlatImagesCell
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! FlatImagesCell
        
        if let urlString =  self.returnedImagesURLs?[indexPath.row].imageDownloadURL
        {
            let url = URL(string:urlString)
            cell.FlatImage.kf.setImage(with: url)
        }
        
        return cell
    }

    // Segue function for passing variable to 'ReservationViewController' and 'ShowUSerProfileViewController'
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reservationSegue"{
            
            let reservationVC = segue.destination as? ReservationViewController
            
            reservationVC?.receivedFlat = self.flat
        }
        if segue.identifier == "showUserProfile"{
            
            let showUserVC = segue.destination as! ShowUserProfileViewController
            showUserVC.strUserID = self.ownerID
            

        }
    }

}
