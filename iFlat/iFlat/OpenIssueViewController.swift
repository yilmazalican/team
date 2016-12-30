//
//  OpenIssueViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 31.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class OpenIssueViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,ShowAlert {

    @IBOutlet weak var popUpView: UIView!{
        didSet{
            
            popUpView.layer.cornerRadius = 10
            popUpView.layer.masksToBounds = true
        }
    }
    
    var firebase = FIRUSER()
    
    var issue = Issue()
    
    @IBOutlet weak var contentTextView: UITextView!{
        
        didSet{
            
            contentTextView.delegate = self
            contentTextView.layer.cornerRadius = 10
            contentTextView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var titleTextField: UITextField!{
        didSet{
            
            titleTextField.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.getCurrentLoggedIn { (currentUser) in
            
            self.issue.issuer = currentUser?.id
            
            self.issue.isOpen = true

            
        }
     //    issue.
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openIssueActionButton(_ sender: Any) {
        
        
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        issue.title = textField.text
        
    }
  
    func textViewDidEndEditing(_ textView: UITextView) {
        issue.content  = textView.text
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            contentTextView.resignFirstResponder()
           
            return false
        }
        
        return true
    }

}
