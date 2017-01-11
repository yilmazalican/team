//
//  OpenIssueViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 31.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

public class OpenIssueViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,ShowAlert {

    @IBOutlet weak var popUpView: UIView!{
        didSet{
            
            popUpView.layer.cornerRadius = 10
            popUpView.layer.masksToBounds = true
        }
    }
    
       
    var reportedUser = User()
    
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
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.getCurrentLoggedIn { (currentUser) in
            
            
            self.issue.issuer = currentUser?.id
            
            self.issue.isOpen = "true"

            self.issue.issued = self.reportedUser.id
        }
        
        }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openIssueActionButton(_ sender: Any) {
        
        if self.issue.issued == issue.issuer || issue.content == nil  || issue.title == nil {
           showAlert(title: "Error", message: "You opened a issue about yourself or fill in the blanks.")
            
        }
        
        else {
            
            firebase.openIssue(toUser: reportedUser, issue: issue) { (err) in
               self.dismiss(animated: true, completion: nil)
            }
        }
        
       
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var cancelButtonTapped: UIButton!
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        issue.title = textField.text
        
    }
  
    public func textViewDidEndEditing(_ textView: UITextView) {
        issue.content  = textView.text
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            contentTextView.resignFirstResponder()
           
            return false
        }
        
        return true
    }

}
