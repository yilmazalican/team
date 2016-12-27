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
class ChoosePhotoViewController: UIViewController {

    @IBOutlet weak var choosePhotoCollectionView: ChoosePhotoCollectionView!
    
    var imagePicker = BSImagePickerViewController() {
        
        didSet{
            
            imagePicker.maxNumberOfSelections = 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

    @IBAction func choosePhotoActionButton(_ sender: Any) {
        
        
        
    }
}
