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

     static let sizeNum = [SearchParameter.selectPeopleNum,SearchParameter.one,SearchParameter.two,SearchParameter.three,SearchParameter.four,SearchParameter.moreThan4]
    
    
    static let selectPeopleNum = "Select the number of people."
    static let four = "4"
    static let three = "3"
    static let two = "2"
    static let one = "1"
    static let moreThan4 = "5"
    
    
    static let   selectBedroom = "Select number of bedroom."
    
    static let   selectBed = "Select number of bed."
    
    static let selectCapacity = "Select number of capacity."
    
    static let selectBathroom = "Select number of bathroom"
    
    static let bathroomSize = [SearchParameter.selectBathroom,SearchParameter.one,SearchParameter.two,SearchParameter.three,SearchParameter.moreThan4]
    
    static let bedroomSize = [SearchParameter.selectBedroom,SearchParameter.one,SearchParameter.two,SearchParameter.three,SearchParameter.moreThan4]
    
    
    static let capacity = [SearchParameter.selectCapacity,SearchParameter.one,SearchParameter.two,SearchParameter.three,SearchParameter.moreThan4]

    
    static let bedSize = [SearchParameter.selectBed,SearchParameter.one,SearchParameter.two,SearchParameter.three,SearchParameter.moreThan4]
    
    
    
    
}
