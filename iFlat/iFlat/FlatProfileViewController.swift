//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

//burada eksik var/time fault
    var receivedFlatID: String = ""
    var flat : Flat!
    var ownerID : String = ""
    
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
        self.initGui()
        }
        
        
    }
    
    func initFlat(completion: @escaping (Flat)-> ()){
        
        flat = Flat()
        flat.DB_ENDPOINT.getFlatofUser(userID: ownerID, flatID: receivedFlatID) { (flat) in
            completion(flat as! Flat)
            
        }
        
    }

    func initGui(){
        // check string casting
        self.flatPriceTV.text = String(describing: flat.price)
        self.flatDetailsTV.text = flat.flatDescription!
        self.flatOwnerTV.text = flat.userID
        self.flatTitleTV.text = flat.title
        self.flatSpecsTV.text = "Bathroom:" + String(describing: flat.bathroomCount)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        
        return cell
    }
    


}
