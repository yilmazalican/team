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
    var receivedFilter : FilterModel?
    //var flatCells : [ListFlatCollectionViewCell]?
    var filteredFlats: [FilteredFlat] = []
    
    @IBOutlet weak var listFlatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if receivedFilter == nil{
            receivedFilter = FilterModel()
        }
        getFlatInfoFromFireBase(filter: receivedFilter!)
        
        let endpoint = FIRFlat()
        let USERendpoint = FIRUSER()
        
        USERendpoint.loginByEmailAndPassword(email: "yilmazalican92@gmail.com", password: "frozen4192") { (str) in
            print(str)
        }
        
        let qm = Querymaster()
        let fromDate = Date(dateString: "18/12/2016")
        let toDate = Date(dateString: "20/12/2016")
        let filter = FilterModel(city: "Istanbul", capacity: nil, bathroomcount: nil, bedcount: nil, bedroomcount: nil, pool: false, internet: false, cooling: false, heating: false, tv: false, washingMachine: false, elevator: false, parking: false, gateKeeper: false, priceFrom: 0, priceTo: 9999, smoking: false, fromDate:fromDate, toDate: toDate)
        qm.getFilteredFlats(filter: filter) { (dsa) in
            self.filteredFlats = dsa
            self.listFlatCollectionView.reloadData()
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
        let urle = self.filteredFlats[indexPath.row].flatThumbnailImage?.imageDownloadURL
        if let url = urle
        {
            let urlURL = URL(string: (url))
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.flatThumbnail.image = UIImage(data:data!)
                }
            }
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFlats.count
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
