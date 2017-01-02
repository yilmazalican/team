//
//  ViewController.swift
//  iFlat
//
//  Created by Alican Yilmaz on 24/11/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseDatabase
import Kingfisher


class ControlPanelVC: UITableViewController, ShowAlert, MFMailComposeViewControllerDelegate {
    var dbUser = FIRUSER()


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mailComposeViewController = configuredMailComposeViewController()
        if indexPath.row == 5 && MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)

        
        }
        if indexPath.row == 6{
                    let alert = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        self.dbUser.logout(completion: { (err) in
                            if err == nil{
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }))
                    self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["tolga.taner@isik.edu.tr","alican.yilmaz@isik.edu.tr","tolgataner43@gmail.com"])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
        
    }
    
    
    

}



