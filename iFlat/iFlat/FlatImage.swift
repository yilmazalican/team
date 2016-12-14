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
    var imageID:String
    var imageDownloadURL:String
    var imageOrder:Int
    
    init(imageID:String, imageDownloadURL:String,imageOrder:Int) {
        self.imageID = imageID
        self.imageDownloadURL = imageDownloadURL
        self.imageOrder = imageOrder
    }
    
}

class FlatImage
{
    var imageOrder:Int
    var image:UIImage
    
    init(imageOrder:Int, image:UIImage) {
        self.imageOrder = imageOrder
        self.image = image
    }
    
}
