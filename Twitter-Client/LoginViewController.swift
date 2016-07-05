//
//  ViewController.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/5/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    // TODO: Change the layout of this screen
    override func viewDidLoad() {
        super.viewDidLoad()

        //Add login button
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
            
                print("signed in as \(unwrappedSession.userName)");
                
                //Instantiate MainViewController
                let mainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewControllerId") as! MainViewController
                
                //PresentViewController on the main thread
                //Without this we get the “attempt to present ViewController whose view is not in the window hierarchy”
                //Because at this point in execution the view would not be have displayed yet
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentViewController(mainViewController, animated: true, completion: nil)
                })

            } else {
                print("Login error: %@", error!.localizedDescription);
            }
        }
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

