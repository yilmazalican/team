//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var scroller: UIScrollView!
    @IBOutlet var flatPrice: UILabel!
    
    var receivedFlatID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


        //scroller.contentSize = CGSize(width: 375, height: 1500)
        //flatPrice.text = receivedFlatID

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }


}
