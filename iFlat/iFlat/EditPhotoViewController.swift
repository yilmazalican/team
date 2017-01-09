//
//  EditPhotoViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker

class EditPhotoViewController: UIViewController,imageMaker {

    
    var imagePicker = BSImagePickerViewController()
    var parentVC : EditFlatViewController?

    
    @IBOutlet weak var editPhotoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var editPhotoCollectionView: EditPhotoCollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
   
    
    var flatImage = [FlatImage]()
  
    var firebase = FIRFlat()
    
    var flat = Flat()
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {

        self.parentVC?.editingFlat = self.flat
        self.dismiss(animated: true, completion: nil)


    }
    @IBOutlet weak var popUpView: UIView!{
        didSet{
            popUpView.layer.cornerRadius = 10
            popUpView.layer.masksToBounds = true

            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flat.images = [FlatImage]()
        imagePicker.maxNumberOfSelections = 4

        
        firebase.getFlatImages(flatID:flat.id) { (urlImagesURL) in
            
            for url in urlImagesURL! {
                
            self.urlToImage(url: url.imageDownloadURL, completionHandler: { (image) in
                
                self.editPhotoCollectionView.flatImages.append(FlatImage(image: image))
               self.flatImage.append(FlatImage(image: image))
                
            })
            }
            self.indicator.stopAnimating()
                self.doneButton.isEnabled = true
            self.editPhotoButton.isEnabled = true
         
            
            
            self.editPhotoCollectionView.reloadData()
            
            
            

         
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func editPhotoButtonAction(_ sender: Any) {
             
        
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
                manager.requestImage(for: image, targetSize: CGSize(width:self.editPhotoCollectionView.frame.width,height:self.editPhotoCollectionView.frame.height), contentMode: .aspectFill, options: option, resultHandler: { (image, nil) in
                    
                    
                    self.editPhotoCollectionView.flatImages.insert(FlatImage(image: image!), at: count)
                    self.editPhotoCollectionView.flatImages.removeLast()
                    self.flat.images?.append(FlatImage(image:image!))
                   
                    
                    
                   self.editPhotoCollectionView.reloadData()
                })
                
                
            }
       
            
            self.imagePicker.doneButton.isEnabled = true
            count = 0
            self.imagePicker.takePhotos = true
        }, completion: nil)
    }
    
    
    

    }

