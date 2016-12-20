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
import Kingfisher

class ControlPanelVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var imageCache = [String:UIImage]()
    var filteredFlats: [FilteredFlat] = []
    var cellArr = [TableViewCell]()
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.imgv.image = nil
       
    if let urlString =  self.filteredFlats[indexPath.row].flatThumbnailImage?.imageDownloadURL
        {
            let url = URL(string:urlString)
            cell.imgv.kf.setImage(with: url)
        }
        
       return cell
    }
    


    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredFlats.count
    }


    @IBOutlet weak var myTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let endpoint = FIRFlat()
        let USERendpoint = FIRUSER()

        USERendpoint.loginByEmailAndPassword(email: "eposta.alican@gmail.com", password: "frozen4192") { (str) in
            print(str)
        }



        

        
       
    
        let image1 = FlatImage(image: UIImage(named:"1")!)

        for a in 1...20
        {
            var images = [FlatImage]()
            

            images.append(image1)
           
        let f = Flat(title: "dsadsa", flatDescription: "dsadsa", city: "Istanbul", address: "dsadsa", flatCapacity: 3, bathRoomCount: 4, bedcount: 4, pool: true, internet: true, cooling: true, heating: true, tv: true, washingMachine: false, elevator: false, parking: false, smoking: false, gateKeeper: false, price: 120, deleted: false, images: images, bedroomCount: 3)
            endpoint.insertFlat(flt: f, completion: { (str) in
                print(str)
            })
        }
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let qm = Querymaster()
        let fromDate = Date(dateString: "18/12/2016")
        let toDate = Date(dateString: "20/12/2016")
        let filter = FilterModel(city: "Istanbul", capacity: 3, bathroomcount: nil, bedcount: nil, bedroomcount: nil, pool: false, internet: false, cooling: false, heating: false, tv: false, washingMachine: false, elevator: false, parking: false, gateKeeper: false, priceFrom: 0, priceTo: 125, smoking: false, fromDate:fromDate, toDate: toDate)
        qm.getFilteredFlats(filter: filter) { (dsa) in
            self.filteredFlats = dsa
            DispatchQueue.main.async {
                self.myTV.reloadData()
                
            }
        }

    }
    
    
    
    


}



