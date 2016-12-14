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
    
    func initFlat() -> Flat{
        return Flat()
    }

    func initGui(){
        // check string casting
        self.flatPriceTV.text = String(describing: flat.price)
        self.flatDetailsTV.text = flat.flatDescription!
        
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
