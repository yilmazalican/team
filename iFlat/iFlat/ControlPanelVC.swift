//
//  ViewController.swift
//  iFlat
//
//  Created by Alican Yilmaz on 24/11/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ControlPanelVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var filteredFlats: [FilteredFlat] = []
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let url = self.filteredFlats[indexPath.row].flatThumbnailImage?.imageDownloadURL
        let urlURL = URL(string: url!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.imgv.image = UIImage(data:data!)
            }
        }
        return cell
        

    
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFlats.count
    }


    @IBOutlet weak var myTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpoint = FIRFlat()
        let qm = Querymaster()
        let fromDate = Date(dateString: "18/12/2016")
        let toDate = Date(dateString: "20/12/2016")
        let filter = FilterModel(city: "Istanbul", capacity: 3, bathroomcount: nil, bedcount: nil, bedroomcount: nil, pool: false, internet: false, cooling: false, heating: false, tv: false, washingMachine: false, elevator: false, parking: false, gateKeeper: false, priceFrom: 0, priceTo: 125, smoking: false, fromDate:fromDate, toDate: toDate)
        qm.getFilteredFlats(filter: filter) { (dsa) in
            self.filteredFlats = dsa
            self.myTV.reloadData()
        }

        
        
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
