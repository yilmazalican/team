//
//  ReservationController.swift
//  iFlat
//
//  Created by Alican Yilmaz on 10/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class HostReservation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var flatEndpoint = FIRFlat()
    var customDateBabyInstance: CustomDateDay?
    var flatCalendarItem = [FlatCalendarItem]()
    var selectedIndexes:Int = 0    
    var trueControl:Int = 0 
    var cellArr = [CalendarCell]()
    
    @IBOutlet weak var timeTableTV: UITableView!
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.customDateBabyInstance?.sectionL.count)!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.customDateBabyInstance?.sectionL[section]
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CalendarCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.isUserInteractionEnabled = true
        cell.calendarDayLabel.text = String(describing:(self.customDateBabyInstance!.dayList[indexPath.section][indexPath.row]).day)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.customDateBabyInstance?.dayList[section].count)!
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customDateBabyInstance = CustomDateDay()
    }
    
    

    @IBAction func doneTapped(_ sender: UIButton) {
        let selectedCells = timeTableTV.indexPathsForSelectedRows
        var arr = [Int]()
        for a in selectedCells!{
            let date = (self.customDateBabyInstance!.dayList[a.section][a.row]).date
            arr.append(date.toTimeStamp())
        }
        
        let controllers = self.navigationController?.viewControllers
        for a in controllers!{
            if a is AddFlatViewController{
                let b = a as! AddFlatViewController
                b.timeSlots = arr
            }
        }
        navigationController?.popViewController(animated: true)       

        
        
        
        
    }


    
}



