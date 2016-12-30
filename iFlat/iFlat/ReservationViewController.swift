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
    
    @IBOutlet var yearLabel: UILabel!
    var flatID : String!
    var selectedDayRange : [Date]?
    var selectedExactDates : [Date] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendarView.allowsMultipleSelection = true
        calendarView.rangeSelectionWillBeUsed = true
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        
        //calendarView.registerHeaderView(xibFileNames: ["CalendarHeader"])
        
        calendarView.visibleDates { (visibleDates: DateSegmentInfo) in
            self.updateMonthYearLabel(visibleDates: visibleDates)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

extension ReservationViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let startDate = Date()
        // add one year
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
        let dayCell = cell as! CellView
        
        // Setup Cell text
        dayCell.dayLabel.text = cellState.text
        
        //dayCell.selectedView.isHidden = true;
        // Setup text color
        if cellState.dateBelongsTo == .thisMonth {
            dayCell.dayLabel.textColor = UIColor.black
        } else {
            dayCell.dayLabel.textColor = UIColor.gray
        }
        
        handleCellSelection(view: cell, cellState: cellState, date: date)
        
        
        
        
    }
    // This sets the height of your header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    // This setups the display of your header
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        
        
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        updateMonthYearLabel(visibleDates: visibleDates)
    }
    
    func updateMonthYearLabel(visibleDates: DateSegmentInfo){
        
        let calendar = Calendar.current
        let firstDay = visibleDates.monthDates.first?.timeIntervalSince1970
        let intMonth = calendar.component(.month, from: Date(timeIntervalSince1970: firstDay!))
        let intYear = calendar.component(.year, from: Date(timeIntervalSince1970: firstDay!))
        let monthName = DateFormatter().monthSymbols[(intMonth-1)%12]
        self.yearLabel.text = monthName + " " + String(intYear)
    }
    
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState, date: Date) {
        guard let dayCell = view as? CellView else {
            return
        }
        
        // add selected range's dates to selectedExactDates array
        
        if calendarView.selectedDates.count < 2 {
            if cellState.isSelected{
                dayCell.selectedView.isHidden = false
                
            }else{
                dayCell.selectedView.isHidden = true
            }
        }
        else if calendarView.selectedDates.count == 2 {
            let first = calendarView.selectedDates.first
            let last = calendarView.selectedDates.last
            var iterator = first
            while(iterator != last?.addingTimeInterval(24*60*60)){
                selectedExactDates.append(iterator!)
                
                calendarView.selectDates([iterator!], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
                iterator?.addTimeInterval(24*60*60)
                
            }
            
            
            
        }else {
        
        
        
        
        
        // check cell, is it in selectedExactDates array?
        if (selectedExactDates.contains(date)){
            dayCell.selectedView.isHidden = false
        }else{
            dayCell.selectedView.isHidden = true
        }

            //print("selected dates>")
            //print(selectedExactDates)
        
        
        }
        
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState, date: date)
        print("--->")
        print(calendarView.selectedDates)
        if calendarView.selectedDates.count == 2 {
            selectedDayRange = calendarView.selectedDates
            
            
        }else if (calendarView.selectedDates.count > 2 && calendarView.selectedDates.count > selectedExactDates.count) {
            var currentSelectedDates = calendarView.selectedDates
            for loopdate in selectedExactDates{
                if currentSelectedDates.contains(loopdate){
                    currentSelectedDates.remove(at: currentSelectedDates.index(of: loopdate)!)
                }
            }
            calendarView.deselectAllDates()
            calendarView.selectDates(currentSelectedDates)
            selectedExactDates.removeAll()
            
        }
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        let dayCell = cell as? CellView
        dayCell?.selectedView.isHidden = true
    }
    
    
    
    
    
}
