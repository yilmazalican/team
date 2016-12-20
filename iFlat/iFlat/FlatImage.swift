//
//  FlatImage.swift
//  iFlat
//
//  Created by Alican Yilmaz on 14/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import UIKit
class FlatImageDownloaded
{
    var imageID:String?
    var imageDownloadURL:String!
    
    init(imageID:String, imageDownloadURL:String) {
        self.imageID = imageID
        self.imageDownloadURL = imageDownloadURL
    }
    
    init()
    {
        
    }
    
}

class FlatImage
{
    
    var id:String
    var image:UIImage
    
    init(image:UIImage) {
        self.id = UUID().uuidString
        self.image = image
    }
    
}
