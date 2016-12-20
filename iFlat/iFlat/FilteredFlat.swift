//
//  FilteredFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 20/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
class FilteredFlat
{
    var flatID:String?
    var flatThumbnailImage:FlatImageDownloaded?
    var flatTitle:String?
    var flatPrice:Double?
    var flatCity:String?
    var userID:String?
    
    init(flatID:String?, flatThumbnailImage:FlatImageDownloaded, flatTitle:String?,flatCity:String?, flatPrice:Double?, userID:String?) {
        self.flatID = flatID
        self.flatThumbnailImage = flatThumbnailImage
        self.flatTitle = flatTitle
        self.flatPrice = flatPrice
        self.flatCity = flatCity
        self.userID = userID
    }
    init()
    {
        
    }
    
    
}
