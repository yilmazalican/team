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
class ControlPanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timedFlats = [String]()
        var query = Querymaster()
        var fm = FilterModel(city: "dsa", capacity: nil, bathroomcount: 9, bedcount: 5, bedroomcount: nil, pool: false, internet: false, cooling: false, heating: false, tv: false, washingMachine: false, elevator: false, parking: false, gateKeeper: false, priceFrom: 0, priceTo: 99999999, smoking: false)
        
        query.getFilteredFlats(filter: fm) { (ss) in
            for a in ss
            {
                print(a.flatID)
            }
        }

        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
