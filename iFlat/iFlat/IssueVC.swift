//
//  IssueVC.swift
//  iFlat
//
//  Created by Alican Yilmaz on 11/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class IssueVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var issueTV: UITableView!
    let userEndpoint = FIRUSER()
    var issuesArr = [Issue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issuesArr.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell") as! issueCell
        cell.issueTitleLbl.text = self.issuesArr[indexPath.row].title
        cell.issueContentLbl.text = self.issuesArr[indexPath.row].content
        cell.statusLbl.text = self.issuesArr[indexPath.row].isOpen
        switch cell.statusLbl.text!{
            case "true":
            cell.statusLbl.text = "Yes"
            break
            case "false":
            cell.statusLbl.text = "No"
            break
        default:
            break
        }
        cell.AnswerLbl.text = self.issuesArr[indexPath.row].answer
        return cell
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userEndpoint.getCurrentLoggedIn { (usr) in
            self.userEndpoint.getISsue(user: usr!, completion: { (issues) in
                self.issuesArr = issues
                self.issueTV.reloadData()
            })

        }
    }

}
