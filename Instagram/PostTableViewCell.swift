//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Santos Solorzano on 3/6/16.
//  Copyright © 2016 santosjs. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var homePostImageView: UIImageView!
    @IBOutlet weak var postCaptionText: UITextView!
    
    var post: Post? {
        didSet {
            postCaptionText.text = post?.caption!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
