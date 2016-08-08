//
//  NewCell.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/5.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher

class NewCell: UITableViewCell {

    @IBOutlet weak var newImage: UIImageView!
    
    @IBOutlet weak var newTitle: UILabel!
    
    var story:Story? {
        didSet{
            newTitle.text = story?.title
            
            let url = NSURL(string:(story?.images![0])!)
            newImage.kf_setImageWithURL(url!)
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
