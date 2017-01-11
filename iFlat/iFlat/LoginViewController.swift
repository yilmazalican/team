//
//  LoginViewController.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 01/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController,UITextFieldDelegate,ShowAlert {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var user = User()
    var dbbridge2 = FIRUSER()

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {

        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        dbbridge2.getCurrentLoggedIn(completion: { (usr) in
            if usr != nil{  
                self.dbbridge2.isUserBanned(usrID: (usr?.id)!, completion: { (comp) in
                    if comp == true{
                        let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "mainFlow")
                        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                        self.indicator.stopAnimating()

                    }
                    else{
                        let appDelegate = UIApplication.shared.delegate
                        let window = appDelegate!.window!
                        
                        if window?.visibleViewController is LoginViewController {
                            self.showAlert(title: "Banned", message: "You have been banned! Contact support team.")
                            self.indicator.stopAnimating()
                            
                        }
                        else{
                            self.dismiss(animated: true, completion: { 
                                self.showAlert(title: "Banned", message: "You have been banned! Contact support team.")
                                self.indicator.stopAnimating()
                                
                            })
                        }
                        self.dbbridge2.logout(completion: { (str) in
                            if str != nil{
                                fatalError()
                            }
                        })

                    }
                })
                
            }
            else{
                self.indicator.stopAnimating()

            }
        })





    }
    /// This method is check password text field and password text field written by users,
    /// if user do not write in this area,method is return value false.
    /// This methos is return value boolean.
    func validationLoginField() -> Bool {

        if !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!{

            return true
        }

        else {

            return false
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /// This method provides to send verify email in the user's email.
    /// if user own forgot password,send reset password by the system to users email box.
    /// also this method sends warning message to user.
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your email..."
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0] {
                self.dbbridge2.forgotPassword(email: (textField.text)!, completion: { (err) in
                    if err != nil
                    {
                        let alert2 = UIAlertController(title: "Error Password", message: "User not found or Badly Formatted Email", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                        }
                        alert2.addAction(okAction)
                        self.present(alert2, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert3 = UIAlertController(title: "Success", message: "Reset password email sent! Check your email.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                        }
                        alert3.addAction(okAction)
                        self.present(alert3, animated: true, completion: nil)

                    }
                })}
        }))
        self.present(alert, animated: true, completion: nil)


    }




    @IBAction func LoginTapped(_ sender: UIButton) {
        self.indicator.startAnimating()
        if validationLoginField(){
                dbbridge2.getByEmail(email: self.emailTextField.text!, completion: { (usr) in
                    if usr != nil{
                    self.dbbridge2.isUserBanned(usrID: (usr?.id)!, completion: { (result) in
                        if result == true{
                            self.dbbridge2.loginByEmailAndPassword(email: (usr?.email)!, password: self.passwordTextField.text!, completion: { (result) in
                                if result == nil{
                                    self.dbbridge2.isUserVerified(completion: { (verified) in
                                        if verified{
                                            let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "mainFlow")
                                            self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                                            self.indicator.stopAnimating()
                                        }
                                        else{
                                            self.dbbridge2.logout(completion: { (result) in
                                                self.showAlert(title: "FATAL", message: "You have not been verified. Please check yourt email to verify.")
                                                self.indicator.stopAnimating()

                                            })
                                        }
                                    })
                                   
                                }
                                else{
                                    self.showAlert(title: "Fatal", message: "Email found, but Wrong password. Check your info.")
                                    self.indicator.stopAnimating()

                                }
                            })
                        }
                        else{
                            let appDelegate = UIApplication.shared.delegate
                            let window = appDelegate!.window!

                            if window?.visibleViewController is LoginViewController {
                                self.showAlert(title: "Banned", message: "You have been banned! Contact support team.")
                                self.indicator.stopAnimating()

                            }
                            else{
                                self.dismiss(animated: true, completion: { 
                                    self.showAlert(title: "Banned", message: "You have been banned! Contact support team.")
                                    self.indicator.stopAnimating()

                                })
                            }
                            self.dbbridge2.logout(completion: { (str) in
                                if str != nil{
                                    fatalError()
                                }
                            })
                        }
                    })
                    }
                    else
                    {
                        self.showAlert(title: "Fatal", message: "Wrong Email! Check your email.")
                        self.indicator.stopAnimating()

                    }
                })

        }
        else
        {
            self.showAlert(title: "Error", message: "Fill in the blanks!")
            self.indicator.stopAnimating()


        }






    }



}



public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }

    public static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

