//
//  FlatProfileViewController.swift
//  iFlat
//
//  Created by MAC ADMIN on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FlatProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var flatPrice: UILabel!
    @IBOutlet weak var flatProfileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //flatPrice.text =
        
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
