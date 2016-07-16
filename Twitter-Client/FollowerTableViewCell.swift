//
//  FollowerTableViewCell.swift
//  Twitter-Client
//
//  Created by Ahmed Baracat on 7/9/16.
//  Copyright © 2016 Ahmed Baracat. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Remove unneeded padding
        descriptionTextView.textContainer.lineFragmentPadding = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
