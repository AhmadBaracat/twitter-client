//
//  FollowerViewController.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/12/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit

class FollowerViewController: UIViewController {
    
    var follower: User?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the title of the navigation bar
        title = follower?.name
        
        profileImageView.image = UIImage.loadImageFromDisk(follower!.profile_image_url)
        profileImageView.layer.borderWidth = 3
        
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        //Set the banner image
        if let backgroundImageURL = follower?.profile_banner_url
        {
            backgroundImageView.image = UIImage.loadImageFromDisk(backgroundImageURL)
        }
        else
        {
            backgroundImageView.image = UIImage.loadImageFromDisk("")
        }
        
        /*
        if let backgroundColor = follower?.profile_background_color
        {
            navigationController?.navigationBar.barTintColor = UIColor(hexString: backgroundColor)
        }
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
