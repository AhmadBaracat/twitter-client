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
        
        return UIImage()
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
