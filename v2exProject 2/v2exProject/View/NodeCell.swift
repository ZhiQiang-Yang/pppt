//
//  NodeCell.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/4.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate
import ObjectMapper
class NodeCell: UITableViewCell {

    @IBOutlet weak var nodeImage: UIImageView!
    @IBOutlet weak var nodeTitle: UILabel!
    @IBOutlet weak var nodeStars: UILabel!
    @IBOutlet weak var nodeIntro: UILabel!
    @IBOutlet weak var nodeCreate: UILabel!
    
    var node:Node?{
        didSet{
            if let url = node!.avatar_normal {
                self.nodeImage.kf_setImageWithURL(NSURL(string: "https:\(url)")!)
            }
            
            self.nodeTitle.text = (node!.title) ?? "无"
            self.nodeStars.text = "\((node?.stars) ?? 0)人点赞"
            self.nodeIntro.text = node!.header
            self.nodeCreate.text = node!.created?.toString()

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
