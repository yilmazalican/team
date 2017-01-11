//
//  CustomDateDay.swift
//  iFlat
//
//  Created by Alican Yilmaz on 10/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import Foundation
struct Objects {
    var sectionName:String!
    var sectionObjects: [Int]!
}

class CustomDateDay{
    let calendar = Calendar.current
    let fmt = DateFormatter()
    var sectionL = [String]()
    var dayList = [[CustomDateCell]]()
    
    
    func getAllDates()
    {
        for a in getDateInRange(){
            
            let monthYear = fmt.monthSymbols[calendar.component(.month, from: a) - 1] + " " + String(describing:calendar.component(.year, from: a))
            let cell = CustomDateCell(isAvailable: true, date: a)
           
            if(!sectionL.contains(monthYear)){
                sectionL.append(monthYear)
                self.dayList.append([CustomDateCell]())
            }
            self.dayList[sectionL.count - 1].append(cell)       
        }
        
    }
    
    func getDateInRange() -> [Date]{
        var startDate = Date()
        var endDate = Date()
        endDate = startDate.addingTimeInterval(TimeInterval(60*60*24*365))
        fmt.dateFormat = "dd/MMMM/yyyy"
        var arr = [Date]()
        while startDate <= endDate {
            arr.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        return arr
    }
    
    
    init() {
        getAllDates()
    }
   
    
}



struct CustomDateCell{
    var isAvailable:Bool
    var date:Date
    var day:Int
    
    init(isAvailable:Bool, date:Date) {
        let calendar = Calendar.current
        self.isAvailable = isAvailable
        self.date = date
        self.day = calendar.component(.day, from: date)
    }
}
