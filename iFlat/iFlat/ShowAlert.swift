//
//  ShowAlert.swift
//  iFlat
//
//  Created by Tolga Taner on 6.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import UIKit



protocol ShowAlert {
    
}


extension ShowAlert where Self: UIViewController {
    
    
    func defaultAlert() {
        
        let alert = UIAlertController(title:"Hata" , message: "Bu cihaz fotoğraf çekmeye uygun değildir.Lütfen Uygun cihazı seçiniz.",preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Tamam" , style: UIAlertActionStyle.default,handler :nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title:title, message: message ,preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Tamam" , style: UIAlertActionStyle.default,handler :nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
