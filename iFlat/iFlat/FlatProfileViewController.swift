//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    var receivedFlatID: String = ""
    var flat : FlatModel!
    
    @IBOutlet var flatRating: UILabel!
    @IBOutlet var flatRatingTV: UILabel!
    @IBOutlet var flatSpecsTV: UILabel!
    @IBOutlet var flatPriceTV: UILabel!
    @IBOutlet var flatDetailsTV: UILabel!
    @IBOutlet var flatOwnerTV: UILabel!
    @IBOutlet var flatTitleTV: UILabel!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flat = initFlat()
        initGui()
        
    }
    
    func initFlat() -> FlatModel{
        return FlatModel()
    }

    func initGui(){
        //self.flatPriceTV = flat.price!
        //self.flatDetailsTV = flat.description!
        
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
