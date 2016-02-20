//
//  LoginViewController.swift
//  Instaham
//
//  Created by Hugh A. Miles II on 2/20/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedLoginBtn(sender: AnyObject) {
        //check if user is in database
        if(usernameField.text != "" || passwordField.text != ""){
            PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("User Exist")
                    self.performSegueWithIdentifier("gotoCollectionView", sender: nil)
                }
                    
                else {
                    // The login failed. Check error to see why.
                    let alertController = UIAlertController(title: "Error", message: "Invalid password/username", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // ...
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                        // ...
                    }
                    
                }
            }
        }
            
        else {
            let alertController = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
