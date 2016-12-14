//
//  ListFlatViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var flatProfileVC : FlatProfileViewController?
    //var oldFilter : FilterModel?
    
    // IMPORTANT -> Search must fill receivedFilter by FilterModel Instance
    var receivedFilter : FilterModel?
    
    @IBOutlet weak var listFlatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if receivedFilter == nil{
            receivedFilter = FilterModel()
        }
        getFlatInfoFromFireBase(filter: receivedFilter!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFlatInfoFromFireBase(filter : FilterModel){
        
        print("getFlatInfoCalled")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize(width: (UIScreen.main.bounds.width),height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : ListFlatCollectionViewCell = listFlatCollectionView.dequeueReusableCell(withReuseIdentifier: "flatCell", for: indexPath) as! ListFlatCollectionViewCell
        cell.flatCity.text = "istanbul"
        cell.flatPrice.text = "500"
        cell.flatRating.text = "***"
        cell.flatID = String(indexPath.row)

        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell = listFlatCollectionView.cellForItem(at: indexPath) as! ListFlatCollectionViewCell
         flatProfileVC?.receivedFlatID = cell.flatID
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flatProfileSegue"{
        let navigationController = segue.destination as! UINavigationController
            
        flatProfileVC = navigationController.topViewController as! FlatProfileViewController
            
        }
        else if segue.identifier == "filterSegue"{
            let filterVC = segue.destination as! FiltersViewController
            filterVC.filter = self.receivedFilter
        }

        
        
        
    }

}
