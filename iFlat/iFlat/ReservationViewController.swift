//
//  ReservationViewController.swift
//  iFlat
//
//  Created by Eren AY on 26/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//


import JTAppleCalendar

class ReservationViewController: UIViewController {
    @IBOutlet var calendarView: JTAppleCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        
        calendarView.registerHeaderView(xibFileNames: ["CalendarHeader"])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension ReservationViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(TimeInterval(31536000))
        
        //let startDate = formatter.date(from: "2016 01 26")! // You can use date generated from a formatter
        //let endDate = Date()                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .monday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        // Setup text color
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = UIColor.black
        } else {
            myCustomCell.dayLabel.textColor = UIColor.gray
        }
        
        
    }
    // This sets the height of your header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    // This setups the display of your header
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        
        let date = Date()
        let calendar = Calendar.current
        let middleDay = (Int(range.start.toTimeStamp())! + Int(range.end.toTimeStamp())!)/2
        
        let intMonth = calendar.component(.month, from: Date(timeIntervalSinceNow: TimeInterval(middleDay)))
        let monthName = DateFormatter().monthSymbols[(intMonth-1)%12]
        let headerCell = (header as? CalendarHeader)
        headerCell?.calendarHeaderLabel.text = String(monthName)
    }
    
    
}
