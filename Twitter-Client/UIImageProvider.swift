//
//  ImageProvider.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/16/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit
import ImageViewer

class UIImageProvider: ImageProvider {
    
    var image = UIImage()
    
    init(image: UIImage)
    {
        self.image = image
    }
    
    func provideImage(completion: UIImage? -> Void) {
        completion(image)
    }
    
    func provideImage(atIndex index: Int, completion: UIImage? -> Void) {
        completion(nil)
    }
}
