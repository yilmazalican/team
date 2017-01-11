//
//  ChoosePhotoViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 28.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
class ChoosePhotoViewController: UIViewController,ShowAlert {

    @IBOutlet weak var choosePhotoCollectionView: ChoosePhotoCollectionView!
    
    var imagePicker = BSImagePickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   imagePicker.maxNumberOfSelections = 4
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoSegue" {
            if let controller : AddFlatViewController = segue.destination as? AddFlatViewController {
                for image in choosePhotoCollectionView.selectedImage {
                controller.flatImage.append(FlatImage(image: image))
                }
                
            }
            
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if choosePhotoCollectionView.selectedImage.contains(#imageLiteral(resourceName: "defaulthome")) {
        showAlert(title: "Error", message: "Choose Photo before passing.")
            return false
        }
        else {
            return true
        }
        
        
    }
  

    @IBAction func choosePhotoActionButton(_ sender: Any) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        
        var count = 0
        
        imagePicker.doneButton.isEnabled = false
        
        if imagePicker.takePhotos {
            count = 4
        }
        
        bs_presentImagePickerController(imagePicker, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                       count = count + 1
                                            if count == 4{
                                                self.imagePicker.doneButton.isEnabled = true
                                            }
                                            else
                                            {
                                                self.imagePicker.doneButton.isEnabled = false
                                                
                                            }

                                            
        }, deselect: { (asset: PHAsset) -> Void in
             count = count - 1
            if count == 4{
                self.imagePicker.doneButton.isEnabled = true
            }
            else
            {
                self.imagePicker.doneButton.isEnabled = false
                
            }
          
                }, cancel: { (assets: [PHAsset]) -> Void in
                    count = 0
                    
                    }, finish: { (assets: [PHAsset]) -> Void in
           for image in assets {
            manager.requestImage(for: image, targetSize: CGSize(width:self.choosePhotoCollectionView.frame.width,height:self.choosePhotoCollectionView.frame.height), contentMode: .aspectFill, options: option, resultHandler: { (image, nil) in
                
                self.choosePhotoCollectionView.selectedImage.insert(image!, at: count)
                self.choosePhotoCollectionView.selectedImage.removeLast()
                 self.choosePhotoCollectionView.reloadData()
                 })
            
            
            }
            
          self.imagePicker.doneButton.isEnabled = true
            count = 0
                        self.imagePicker.takePhotos = true
        }, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
   
        
    }

