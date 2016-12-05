//
//  SearchParameter.swift
//  iFlat
//
//  Created by Tolga Taner on 1.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//



class SearchParameter {
    
    var whereParameter : String?
    var toParameter : String?
    var fromParameter: String?
    var numberOfSize:String?

     static let sizeNum = [SearchParameter.selectPeopleNum,SearchParameter.onePerson,SearchParameter.twoPeople,SearchParameter.threePeople,SearchParameter.fourPeople,SearchParameter.moreThan4]
    
    
    
    static let selectPeopleNum = "Kişi Sayısını Seçiniz"
    static let fourPeople = "4 Kişi"
    static let threePeople = "3 Kişi"
    static let twoPeople = "2 Kişi"
    static let onePerson = "1 Kişi"
    static let moreThan4 = "4+"
    
}
