//
//  TimelineViewController.swift
//  Instaham
//
//  Created by Hugh A. Miles II on 2/20/16.
//  Copyright © 2016 Hugh A. Miles II. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var timeline:[PFObject] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        getPostFromParse() // query post
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPostFromParse() {
        let timelineQuery =  PFQuery(className: "Timeline")
        timelineQuery.findObjectsInBackgroundWithBlock {
            (objects : [PFObject]?, error : NSError?) -> Void in
            
            if error == nil {
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        print(object.objectId)
                    }
                    self.timeline = objects
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: - UICollectionViewDelegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return timeline.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hexCell", forIndexPath: indexPath) as! hexCellCollectionViewCell
        let tempObj = timeline[indexPath.row]
        
        cell.label.text = tempObj["username"] as? String
        if tempObj["comment"] != nil {
        cell.comment.text = tempObj["comment"] as? String}
        
        let imageFile : PFFile = tempObj["picture"] as! PFFile
        imageFile.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?)
            -> Void in
            if (error == nil) {
                cell.postPic.image = UIImage(data: imageData!)
            }
        }
        
        return cell
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
