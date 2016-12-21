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
    
    
    // IMPORTANT -> Search must fill receivedFilter by FilterModel Instance

    var receivedFilter : FilterModel? = FilterModel(city: "Istanbul", capacity: 3, bathroomcount: nil, bedcount: nil, bedroomcount: nil, pool: false, internet: false, cooling: false, heating: false, tv: false, washingMachine: false, elevator: false, parking: false, gateKeeper: false, priceFrom: 0, priceTo: 125, smoking: false, fromDate: Date(dateString: "18/12/2016"), toDate: Date(dateString: "20/12/2016"))
    //var flatCells : [ListFlatCollectionViewCell]?
    var filteredFlats: [FilteredFlat] = []
    
    @IBOutlet weak var listFlatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if receivedFilter == nil{
            receivedFilter = FilterModel()
        }
        
        let endpoint = FIRFlat()
        let USERendpoint = FIRUSER()
        
        USERendpoint.loginByEmailAndPassword(email: "yilmazalican92@gmail.com", password: "frozen4192") { (str) in
            print(str)
            
            let qm = Querymaster()
            
            
            qm.getFilteredFlats(filter: self.receivedFilter!) { (dsa) in
                self.filteredFlats = dsa
                
                DispatchQueue.main.async {
                    self.listFlatCollectionView.reloadData()
                    
                }
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
            cell.flatPrice.text = String(describing: self.filteredFlats[indexPath.row].flatPrice)
            
            
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return filteredFlats.count
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            var cell = listFlatCollectionView.cellForItem(at: indexPath) as! ListFlatCollectionViewCell
            flatProfileVC?.receivedFlatID = cell.flatID
            flatProfileVC?.ownerID = cell.flatOwnerID
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "flatProfileSegue"{
                let navigationController = segue.destination as! UINavigationController
                
                flatProfileVC = navigationController.topViewController as? FlatProfileViewController

                
            }
            else if segue.identifier == "filterSegue"{
                let filterVC = segue.destination as! FiltersViewController
                filterVC.filter = self.receivedFilter
            }
            
            
            
            
        }
        
        
}


