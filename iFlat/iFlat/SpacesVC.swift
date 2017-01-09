 //
//  SpacesVC.swift
//  iFlat
//
//  Created by Alican Yilmaz on 29/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class SpacesVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var spacesTV: UITableView!
    var dbFlat = FIRFlat()
    var dbUser = FIRUSER()

    var flatsArr = [Flat]()
    var flatImgArr = [String]()
    
    var oldCity:String?
    var oldFlat:ManipulableFlat?

    var currentUsr:User? {
        didSet{
            self.dbFlat.getFlatsofUser(userID: (currentUsr?.id)!) { (flats) in
                self.flatsArr = flats as! [Flat]
                for a in flats!
                {
                    self.dbFlat.getFlatImages(flatID: a.id, completion: { (imgs) in
                        if let firstimg = imgs?.first?.imageDownloadURL{
                            self.flatImgArr.append((firstimg))
                            self.spacesTV.reloadData()
                        }
                       
                    })
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = spacesTV.dequeueReusableCell(withIdentifier: "spacescell", for: indexPath) as! spacescell
        if self.flatImgArr.count - 1 >= indexPath.row{
            let url = URL(string:self.flatImgArr[indexPath.row])
            cell.flatThumbImg.kf.setImage(with: url)
            cell.flatPricesLbl.text = String(describing: self.flatsArr[indexPath.row].price!) + "₺" + "\n per night"
            cell.flatTitleLbl.text = self.flatsArr[indexPath.row].title
            cell.cityCell.text = self.flatsArr[indexPath.row].city
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        return cell
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flatsArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            self.dbFlat.disable(disablingFlat: self.flatsArr[indexPath.row], completion: { (err) in
                self.flatsArr.remove(at: indexPath.row)
                self.spacesTV.deleteRows(at: [indexPath], with: .left)
                self.spacesTV.reloadData()
            })
        }
        delete.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexpath) in
            let storyboard = UIStoryboard(name: "EditFlatStoryboard", bundle: nil)
            let viewControllerYouWantToPresent = storyboard.instantiateViewController(withIdentifier: "EditFlatViewController") as! EditFlatViewController
            self.oldFlat = self.flatsArr[indexPath.row]
            self.oldCity = self.flatsArr[indexPath.row].city
            self.performSegue(withIdentifier: "editFlatsegue", sender: self)
        }
        edit.backgroundColor = UIColor.blue
        
        let publish = UITableViewRowAction(style: .normal, title: "Publish") { (action, indexpath) in
        }
        publish.backgroundColor = UIColor.gray
        

        return [delete, publish, edit]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dbUser.getCurrentLoggedIn { (usr) in
            self.currentUsr = usr as? User
        }
        self.spacesTV.separatorStyle = .none
        self.spacesTV.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editFlatsegue" {
            
            let targetController = segue.destination as! EditFlatViewController
            
            targetController.oldCity = self.oldCity!
            targetController.editingFlat = self.oldFlat as! Flat
        }
        else {
            
            
        }
        
         }
    
    


}
