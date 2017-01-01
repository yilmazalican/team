//
//  WishVC.swift
//  iFlat
//
//  Created by Alican Yilmaz on 01/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class WishVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dbflat = FIRFlat()
    let dbusr = FIRUSER()
   
    var imgsArr = [String:Flat]()
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Wishcell") as! Wishcell
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    @IBOutlet weak var wishTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dbusr.getCurrentLoggedIn { (usr) in
            self.dbusr.getWishes(usrID: (usr?.id)!, completion: { (dict) in
                for a in dict{
                    self.dbflat.getFlatImages(flatID: a.key, completion: { (imgs) in
                        self.dbflat.getFlatofUser(userID: (usr?.id)!, flatID: a.key, completion: { (flt) in
                            self.imgsArr[(imgs?.first?.imageDownloadURL!)!] = flt as! Flat?
                            self.wishTV.reloadData()
                        })
                    })

                }
            })

        }

    }


}
