//
//  ShowUserProfileViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 31.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ShowUserProfileViewController: UIViewController {
    
    var showedUser = User()
    var firebase = FIRUSER()
    
    var strUserID = String()
    
    @IBOutlet weak var userProfileImageView: UIImageView!

    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    
    @IBOutlet weak var mailAdressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        firebase.getUserByID(id: strUserID) { (user) in
            
            self.showedUser = user as! User
            
            self.nameSurnameLabel.text = self.showedUser.name! + " " + self.showedUser.surname!
            self.countryLabel.text = self.showedUser.country
            self.birthdateLabel.text = self.showedUser.birthDate
            self.mailAdressLabel.text = self.showedUser.email
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller :OpenIssueViewController = segue.destination as? OpenIssueViewController {
            controller.reportedUser = showedUser
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
