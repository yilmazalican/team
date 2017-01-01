//
//  ListFlatViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    // IMPORTANT -> Search must fill receivedFilter by FilterModel Instance

    var receivedFilter = FilterModel()
    //var flatCells : [ListFlatCollectionViewCell]?
    var filteredFlats: [FilteredFlat] = []
    var ownerID:String?
    var flatID:String?
    @IBOutlet weak var listFlatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            //receivedFilter = FilterModel()
        
        
        let endpoint = FIRFlat()
        let USERendpoint = FIRUSER()
        
//        USERendpoint.loginByEmailAndPassword(email: "yilmazalican92@gmail.com", password: "frozen4192") { (str) in
//            //print(str)
//            
//            let qm = Querymaster()
//            
//            
//            qm.getFilteredFlats(filter: self.receivedFilter) { (dsa) in
//                self.filteredFlats = dsa
//                
//                DispatchQueue.main.async {
//                    self.listFlatCollectionView.reloadData()
//                    
//                }
//            }
//        }
        
        let qm = Querymaster()
        
        
        qm.getFilteredFlats(filter: self.receivedFilter) { (dsa) in
            self.filteredFlats = dsa
            
            DispatchQueue.main.async {
                self.listFlatCollectionView.reloadData()
                
            }
        }
        
    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
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
            
            
            let cell = listFlatCollectionView.dequeueReusableCell(withReuseIdentifier: "flatCell", for: indexPath) as! ListFlatCollectionViewCell
            if let urlString =  self.filteredFlats[indexPath.row].flatThumbnailImage?.imageDownloadURL
            {
                let url = URL(string:urlString)
                cell.flatThumbnail.kf.setImage(with: url)
            }
            cell.flatID = self.filteredFlats[indexPath.row].flatID!
            cell.flatOwnerID = self.filteredFlats[indexPath.row].userID!
            cell.flatTitle.text = self.filteredFlats[indexPath.row].flatTitle
            cell.flatPrice.text = "₺" + String(describing: self.filteredFlats[indexPath.row].flatPrice!)
            cell.flatCity.text = self.filteredFlats[indexPath.row].flatCity
            cell.flatRating.text = "****"
            
            
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return filteredFlats.count
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = listFlatCollectionView.cellForItem(at: indexPath) as! ListFlatCollectionViewCell
            let storyboard = UIStoryboard(name: "FlatProfile", bundle: nil)

            let flatProfileVC = storyboard.instantiateViewController(withIdentifier: "flatProfile") as! FlatProfileViewController


            performSegue(withIdentifier: "flatProfileSegue", sender: cell)
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          if segue.identifier == "filterSegue"{
                let filterVC = segue.destination as! FiltersViewController
                filterVC.filter = self.receivedFilter
            }
          else if(segue.identifier == "flatProfileSegue"){
          
            let indexPath = listFlatCollectionView.indexPath(for: sender as! ListFlatCollectionViewCell)
            let vc = segue.destination as! FlatProfileViewController
            vc.ownerID = self.filteredFlats[(indexPath?.row)!].userID!
            vc.receivedFlatID = self.filteredFlats[(indexPath?.row)!].flatID!
            }
            
            
            
            
        }
        
        
}


