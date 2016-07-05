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

