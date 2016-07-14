//
//  Extensions.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/12/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit
import CoreData


extension UIImage
{
    static func loadImageFromDisk(url: String) -> UIImage
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Image")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "url", url)
        fetchRequest.predicate = predicate
        
        // Execute Fetch Request
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let data = managedObject.valueForKey("data") {
                    
                    return UIImage(data: data as! NSData)!
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return UIImage(named: "Placeholder")!
    }
    
    static func saveImageToDisk(imageData: NSData, url: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Image", inManagedObjectContext: managedContext)
        
        let image = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        image.setValue(imageData, forKey: "data")
        image.setValue(url, forKey: "url")
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Cound not save \(error)")
        }
    }
    


}


extension UIColor {
    // Creates a UIColor from a Hex string.
    convenience init(hexString: String) {
        var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            let rString: String = (cString as NSString).substringToIndex(2)
            let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            
            var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
            NSScanner(string: rString).scanHexInt(&r)
            NSScanner(string: gString).scanHexInt(&g)
            NSScanner(string: bString).scanHexInt(&b)
            
            self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: CGFloat(1))
        }
        
        
    }
}
