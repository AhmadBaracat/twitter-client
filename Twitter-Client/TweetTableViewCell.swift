//
//  TweetTableViewCell.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/14/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    
    @IBOutlet var tweetImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var tweetImageBottomConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
       
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
