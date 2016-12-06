//
//  RenterEditOwnProfieController.swift
//  iFlat
//
//  Created by Tolga Taner on 5.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation
import MobileCoreServices

class RenterEditOwnProfieController: UIViewController {

    @IBOutlet weak var renterPhotoImageView: UIImageView!
    
    // TODO : CHECK ASPECTFİT,FİLL
    
     var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
	
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func takePhotoAction(_ sender: Any) {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil && UIImagePickerController.availableCaptureModes(for: .front) != nil  {
            
            
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
            }
        }
        
        else {
            
            defaultAlert()
        }
        
    }
   
    
}


extension RenterEditOwnProfieController : ShowAlert,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
       let mediaType  = info[UIImagePickerControllerMediaType] as! String
        
       
        if mediaType == (kUTTypeImage as String) {
            
             self.renterPhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
          }
    
    
    
    
}


