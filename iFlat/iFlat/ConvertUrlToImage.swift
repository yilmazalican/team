//
//  UrlToImageConvert.swift
//  iFlat
//
//  Created by Tolga Taner on 24.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit


protocol imageMaker {
    
}




extension imageMaker {
    
    
    func urlToImage(url:String,completionHandler: (UIImage) -> Void) {
        
        if let url = NSURL(string:(url)) {
            if let data = NSData(contentsOf: url as URL) {
                let image:UIImage = UIImage(data: data as Data)!
                completionHandler(image)
            }
            
        }
        
    }


    
}
