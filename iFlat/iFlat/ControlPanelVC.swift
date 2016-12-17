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
        FIRREF.instance.getRef().child("time_slots").queryStarting(atValue: "1481932800").queryEnding(atValue: "1482105600").observe(.value, with: { (ss) in
            print(ss)
        })
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
