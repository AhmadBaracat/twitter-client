//
//  Helper.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/16/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit
import ImageViewer

class Helper {
    
    @objc func imageTapped(gestureRecognizer: AnyObject)
    {
        if let gesture = gestureRecognizer as? UITapGestureRecognizer
        {
            if let imageView = gesture.view as? UIImageView
            {
                let imageProvider = UIImageProvider(image: imageView.image!)
                let buttonAssets = CloseButtonAssets(normal: UIImage(named:"close_normal")!, highlighted: UIImage(named: "close_highlighted"))
                let configuration = ImageViewerConfiguration(imageSize: CGSize(width: 10, height: 10), closeButtonAssets: buttonAssets)
                
                let imageViewer = ImageViewer(imageProvider: imageProvider, configuration: configuration, displacedView: imageView)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window!.rootViewController?.presentImageViewer(imageViewer)
                
            }
        }
    }

}
