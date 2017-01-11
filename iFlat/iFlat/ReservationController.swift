//
//  ReservationController.swift
//  iFlat
//
//  Created by Alican Yilmaz on 10/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import UIKit

class ReservationController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowAlert {
    var customDateBabyInstance: CustomDateDay?
    var flatCalendarItem = [FlatCalendarItem]()
    var selectedIndexes:Int = 0    
    var trueControl:Int = 0 
    var cellArr = [CalendarCell]()
    let userEndpoint = FIRUSER()
    let flatEndpoint = FIRFlat()
    var flatID:String?
    var ownerID:String?
    //for reservedSlots
    var disabledTimeSlots = [Int]()
    //for disabledSlots
    var returningSlots = [Int]()
    @IBOutlet weak var reservationTTV: UITableView!
    
    
    @IBAction func sendReservationRequestTapped(_ sender: UIButton) {
        //MARK: Select etmezse??
        var selectedTimeSlots = [Int]()
        let selectedRows = self.reservationTTV.indexPathsForSelectedRows
        for a in selectedRows!{
            
            selectedTimeSlots.append((self.customDateBabyInstance!.dayList[a.section][a.row]).date.toTimeStamp())
        }
        
        userEndpoint.getCurrentLoggedIn { (usr) in
            let request = ReservationRequest(renterUID: usr!.id!, hostUID: self.ownerID!, flatID: self.flatID!, timeSlots: selectedTimeSlots)
            self.userEndpoint.sendReservationRequest(req: request, completion: { (err) in
                if err == nil{
                    self.showAlert(title: "Success", message: "Reservation hes been sent.")
                }
            }) 
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.customDateBabyInstance?.sectionL.count)!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexes -= 1
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexes += 1
        let mycell = tableView.cellForRow(at: indexPath) as! CalendarCell
        mycell.isSelected = true
        if selectedIndexes > 2{
            for a in tableView.indexPathsForSelectedRows!{
                tableView.deselectRow(at: a, animated: true)
                mycell.isSelected = false
                
            }
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            selectedIndexes = 1
        }
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.customDateBabyInstance?.sectionL[section]
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell") as! CalendarCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.isUserInteractionEnabled = true
        cell.calendarDayLabel.text = String(describing:(self.customDateBabyInstance!.dayList[indexPath.section][indexPath.row]).day)
        cellAction(sender: cell, indexPath: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.customDateBabyInstance?.dayList[section].count)!
    }
    
    
    
    
    func disabledDays(completion: @escaping ([Int]?) -> ()){
        userEndpoint.getFlatReservations(fltID: self.flatID!) { (reservations) in
            if reservations != nil{
                var dateArr = [Int]()
                for a in reservations!{
                    if a.accepted! > 1{
                        for b in a.timeSlots{
                            dateArr.append(b)
                        }
                    }
                }
                completion(dateArr) 
            }
            else{
                completion(nil)
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customDateBabyInstance = CustomDateDay()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        disabledDays { (disabledTimeSlots) in
            if (disabledTimeSlots?.count) != nil{
                self.disabledTimeSlots = disabledTimeSlots!
                self.reservationTTV.reloadData()
                
            }

        } 
        getAvailableTimeSlotsOfFlat { (returningSlots) in
            self.returningSlots = returningSlots!
            self.reservationTTV.reloadData()

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("dsadsa")
    }
    
    
    
    func getAvailableTimeSlotsOfFlat(completion: @escaping ([Int]?) -> ()){
        userEndpoint.getAvailableTimeSlotsOfFlat(userID: self.ownerID!, fltID: self.flatID!) { (returningSlots) in
            completion(returningSlots)
            self.reservationTTV.reloadData()
        }
    }
    
    func cellAction(sender:CalendarCell, indexPath:IndexPath){
        DispatchQueue.main.async {
            if(self.disabledTimeSlots.contains(self.customDateBabyInstance!.dayList[indexPath.section][indexPath.row].date.toTimeStamp())){
                sender.layer.backgroundColor = UIColor.lightGray.cgColor
                sender.isUserInteractionEnabled = false
            }
            else if(self.returningSlots.contains(self.customDateBabyInstance!.dayList[indexPath.section][indexPath.row].date.toTimeStamp())){
                sender.layer.backgroundColor = UIColor.white.cgColor
                sender.isUserInteractionEnabled = true
                
            }
            else{
                sender.layer.backgroundColor = UIColor.darkGray.cgColor
                sender.isUserInteractionEnabled = false
            }
 
        }
               
    }
    
    
    
    
    
}



