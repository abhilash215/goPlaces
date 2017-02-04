//
//  Signup.swift
//  goPlaces
//
//  Created by abhilash uday on 12/13/16.
//  Copyright © 2016 AbhilashSU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase



class Signup: UIViewController {

    @IBOutlet weak var enterusername: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var enterpassword: UITextField!
    @IBOutlet weak var enteremail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(sender: AnyObject) {
       
        
        let email = self.enteremail.text
        let pass1 = self.enterpassword.text
        let passc =  self.confirmpassword.text
        let username = self.enterusername.text
    
        if(email == ""){
            let alert = UIAlertController(title: "Error", message: "Please Enter Email ID", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        else if(username == ""){
            let alert = UIAlertController(title: "Error", message: "Please Enter Username", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
             self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else  if(pass1 == "" || passc == ""){
            let alert = UIAlertController(title: "Error", message: "Please Enter Password", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
             self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else  if(pass1 != passc){
            let alert = UIAlertController(title: "Error", message: "Passwords do not match.Try Again", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
             self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if(email != "" && pass1 != "" && (pass1 == passc) && username != ""){
            if(pass1?.characters.count < 6){
                let alert = UIAlertController(title: "Error", message: "Password must be at least 6 characters ", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
          
      

            else{
                FIRAuth.auth()?.createUserWithEmail(email!, password: pass1!, completion: {
                    user,error in
                    
                    if(error == nil){
                        let alert = UIAlertController(title: "Account Created", message: "You May now Login.", preferredStyle: UIAlertControllerStyle.Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: {action in
                        self.performSegueWithIdentifier("Loginidentifier", sender: self)
                        })
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                     //   print("created")
                        
                    }
                        
                    
                    else if(error != nil){
                        print(error)
                    }
                    
                    })
                
            }
        }
        
        
            }
    
    
    @IBAction func cancel(sender: AnyObject) {
        enteremail.text = ""
        enterpassword.text = ""
        confirmpassword.text = ""
        enterusername.text = ""
        self.performSegueWithIdentifier("cancelidebtifier", sender: self)
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
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
