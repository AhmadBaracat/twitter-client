//
//  MainViewController.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/5/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit
import TwitterKit
import Argo
import Alamofire
import AlamofireImage
import CoreData


class MainViewController: UITableViewController {
    
    var followers = [User]()
    
    var selectedFollower: User?
    
    let imageCache = AutoPurgingImageCache()
    
    func parseJson(session: TWTRAuthSession, passedData: NSData?)
    {
        do {
            if let data = passedData
            {
                //Convert json String to foundation object
                let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                
                if let j: AnyObject = json {
                    
                    //Map the foundation object to Response object
                    let response: Response? = decode(j)
                    
                    //Add the users to the followers
                    for var user in (response?.users)!
                    {
                        
                        user.profile_image_url = (user.profile_image_url as NSString).stringByReplacingOccurrencesOfString("_normal", withString: "")

                        
                        self.followers.append(user)
                    }
                    
                    //Reload the tableView in order to display the newly added followers
                    self.tableView.reloadData()
                    
                    //Get two pages only
                    // if self.followers.count < 30
                    // {
                    self.getFollowers(session, cursor: (response?.next_cursor_str)!)
                    //}
                }
            }
        } catch let jsonError as NSError {
            print("json error: \(jsonError.localizedDescription)")
        }
        
    }
    
    func getFollowers(session: TWTRAuthSession, cursor: String)
    {
        //If we haven't reached the last page
        if cursor != "0"
        {
            //Instantiate the Twitter client with the userID
            let client = TWTRAPIClient(userID: session.userID)
            
            let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
            var clientError : NSError?
            
            //Add the cursor which indicates which page to fetch
            let params = ["cursor": cursor, "count": "200"]
            
            //Create the Twitter request to get the required http headers
            let twitterRequest = client.URLRequestWithMethod("GET", URL: statusesShowEndpoint, parameters: params, error: &clientError)
            
            //Create the Alamofire reuest
            let request = Alamofire.Manager.sharedInstance.request(twitterRequest)
            
            if(Reachability.isConnectedToNetwork())
            {
                //Initiate the request
                request.responseJSON { (response) in
                    if response.response?.statusCode == 200 {
                        
                        print("Success")
                        
                        //Cache the response
                        let cachedURLResponse = NSCachedURLResponse(response: response.response!, data: (response.data! as NSData), userInfo: nil, storagePolicy: .Allowed)
                        NSURLCache.sharedURLCache().storeCachedResponse(cachedURLResponse, forRequest: twitterRequest)
                        
                        //Parse the response
                        self.parseJson(session, passedData: response.data)
                    }
                    else {
                        
                        print("problem " + String(response))
                        
                        if let error = response.result.value as? NSDictionary
                        {
                            if let errorMessage = error.objectForKey("message") as? String
                            {
                                print("error: " + String(error) + "  errorMessage: " + String(errorMessage))
                            }
                        }
                    }
                }
            }
            else
            {
                if let response = NSURLCache.sharedURLCache().cachedResponseForRequest(twitterRequest)
                {
                    //Parse the response
                    self.parseJson(session, passedData: response.data)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To enable the resizing of the cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        //Get the store of user sessions
        let store = Twitter.sharedInstance().sessionStore
        
        //Get the last user session
        let lastSession = store.session
        
        //Check if user was already logged in
        if let session = lastSession()
        {
            getFollowers(session, cursor: "-1")
            
            //For testing purposes, not to hit the API limit
            // var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
    }
    
    //Test method to fill the followers
    func update() {
        /*
         var user = User(name: "Ahmed Baracat", screen_name: "baracat_wp7", description: "I am a software developer with great passion for design. I have created a number of games and apps for Windows Phone, Android, iOS, watchOS, tvOS :):). I am coo0000000000000llllll", profile_image_url: "https://pbs.twimg.com/profile_images/619282614399180800/IRLGlac6_bigger.jpg")
         
         followers.append(user)
         
         user = User(name: "Fardia", screen_name: "fifo", description: "", profile_image_url: "https://pbs.twimg.com/profile_images/619282614399180800/IRLGlac6_bigger.jpg")
         
         followers.append(user)
         
         //Make sure we display the newly added followers
         tableView.reloadData()
         */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentFollower = followers[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)  as! FollowerTableViewCell
        
        //Add placeholder image
        cell.profileImageView.image = UIImage(named: "Placeholder")
        
        //Populate the cell
        cell.nameLabel?.text = currentFollower.name
        cell.screenNameLabel?.text = "@" + currentFollower.screen_name
        cell.descriptionTextView?.text = currentFollower.description
        
        var profileImageURL = currentFollower.profile_image_url
        
        //Check if there is an Internet connection
        if(Reachability.isConnectedToNetwork())
        {
            //Check for the image in the cache
            if let image = imageCache.imageWithIdentifier(profileImageURL)
            {
                    cell.profileImageView.image = image
            }
            else
            {
                //Fetch profile image
                Alamofire.request(.GET, profileImageURL)
                    .responseImage { response in
                        
                        if let image = response.result.value {
                            
                            //Save the image to disk
                            UIImage.saveImageToDisk(NSData(data: UIImageJPEGRepresentation(image, 1.0)!), url: profileImageURL)
                            
                            //Cache the image
                            self.imageCache.addImage(image, withIdentifier: profileImageURL)
                            
                            //Apply the image to the correct cell
                            if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? FollowerTableViewCell
                            {
                                updateCell.profileImageView.image = image
                            }
                            
                        }
                }
                
                //Fetch background image
                if let backgroundImageURL = followers[indexPath.row].profile_banner_url
                {
                    Alamofire.request(.GET, backgroundImageURL)
                        .responseImage { response in
                            
                            if let image = response.result.value {
                                
                                UIImage.saveImageToDisk(NSData(data: UIImageJPEGRepresentation(image, 1.0)!), url: backgroundImageURL)
                            }
                    }
                }
            }
        }
        else
        {
            cell.profileImageView.image = UIImage.loadImageFromDisk(profileImageURL)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row at index path")
        
        selectedFollower = followers[indexPath.row]
        
        performSegueWithIdentifier("Follower", sender: self)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Prepare for segue")
        
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController = segue.destinationViewController as! FollowerViewController
        
        // Pass the selected object to the new view controller.
        destinationViewController.follower = selectedFollower
        
    }
    
    
}
