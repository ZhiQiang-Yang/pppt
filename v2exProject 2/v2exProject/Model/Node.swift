//
//  Node.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/4.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
//{
    //        "id": 12,
    //        "name": "qna",
    //        "title": "问与答",
    //        "title_alternative": "Questions and Answers",
    //        "url": "http://www.v2ex.com/go/qna",
    //        "topics": 73638,
    //        "avatar_mini": "//cdn.v2ex.co/navatar/c20a/d4d7/12_mini.png?m=1469612548",
    //        "avatar_normal": "//cdn.v2ex.co/navatar/c20a/d4d7/12_normal.png?m=1469612548",
    //        "avatar_large": "//cdn.v2ex.co/navatar/c20a/d4d7/12_large.png?m=1469612548"
    //    }
class Node: NSObject,Mappable {
    var id:Int?
    var name:String?
    var title:String?
    var title_alternative:String?
    var url:String?
    var topics:Int?
    var avatar_mini:String?
    var avatar_normal:String?
    var avatar_large:String?
    var header:String?
    var footer:String?
    var created:NSDate?
    var stars:Int?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    required init?(_ map: Map) {
        
    }
    override init() {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        title <- map["title"]
        title_alternative <- map["title_alternative"]
        url <- map["url"]
        topics <- map["topics"]
        avatar_mini <- map["avatar_mini"]
        avatar_large <- map["avatar_large"]
        avatar_normal <- map["avatar_normal"]
        header <- map["header"]
        footer <- map["footer"]
        created <- (map["created"],DateTransform())
        stars <- map["stars"]
    }
}
