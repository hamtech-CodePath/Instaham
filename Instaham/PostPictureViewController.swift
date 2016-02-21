//
//  PostPictureViewController.swift
//  Instaham
//
//  Created by Hugh A. Miles II on 2/20/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Parse

class PostPictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var tempPicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func selectPhoto(sender: AnyObject) {
        let imageViewController = UIImagePickerController()
        imageViewController.delegate = self
        imageViewController.sourceType = .PhotoLibrary
        imageViewController.allowsEditing = false
        
        self.presentViewController(imageViewController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.tempPicture.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func postPicture(sender: AnyObject) {
        
        if(self.tempPicture.image != nil){
            let imageData = UIImageJPEGRepresentation(self.tempPicture.image!, 1.0)
            let imageFile = PFFile(name:"image.png", data:imageData!)
            
            let userPhoto = PFObject(className:"Timeline")
            if commentTextField.text != "" {
                userPhoto["comment"] = commentTextField.text
            }
            userPhoto["picture"] = imageFile
            userPhoto["username"] = PFUser.currentUser()?.username
            userPhoto["userId"] = PFUser.currentUser()?.objectId
            userPhoto.saveInBackground()
            
            let alertController = UIAlertController(title: "Congrats", message: "Your Photo has been posted!!", preferredStyle: UIAlertControllerStyle.Alert)
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
