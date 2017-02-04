//
//  LoginviewcontrollerViewController.swift
//  goPlaces
//
//  Created by abhilash uday on 12/10/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginviewcontrollerViewController: UIViewController ,UITextFieldDelegate{

   
    @IBOutlet weak var emailfield: B68UIFloatLabelTextField!
   
    @IBOutlet weak var passwordfield: B68UIFloatLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailfield.delegate = self
        passwordfield.delegate = self
        let placeHolColor = UIColor(red:0.77, green:0.77, blue:0.79, alpha:1.0)
        emailfield.attributedPlaceholder = NSAttributedString(string:"Email Id",
                                                                  attributes:[NSForegroundColorAttributeName: placeHolColor])
        passwordfield.attributedPlaceholder = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: placeHolColor])
        
        let btnColor = UIColor(red:0.82, green:0.29, blue:0.35, alpha:1.0)
        emailfield.activeTextColorfloatingLabel = btnColor
        emailfield.textColor = btnColor
        passwordfield.textColor = btnColor
        passwordfield.activeTextColorfloatingLabel = btnColor
        emailfield.inactiveTextColorfloatingLabel = UIColor.lightGrayColor()
        passwordfield.inactiveTextColorfloatingLabel = UIColor.lightGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func login(sender: AnyObject) {
        
        
        emailfield.resignFirstResponder()
        passwordfield.resignFirstResponder()
        
        let email = emailfield.text
        let password = passwordfield.text
        
        print(email, ",", password)
        
        
        if(email != "" && password != ""){
            
            FIRAuth.auth()?.signInWithEmail(email!, password: password!, completion:  {
                user,error in
                
                if(error == nil){
                    self.performSegueWithIdentifier("searchview", sender: self)
                    
                }
                    
                else
                {
                let alert = UIAlertController(title: "Oops", message: "Login Credentails do not match.Try again", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    }
            })
            
            
            
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password ",preferredStyle: UIAlertControllerStyle.Alert )
            let action = UIAlertAction(title: "OK",style: .Default,handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        

    }
    
    
    @IBAction func forgotpassword(sender: AnyObject) {
        
        }

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

