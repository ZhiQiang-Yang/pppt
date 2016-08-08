//
//  Story.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/5.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
// 把 json 格式的数据转换成对象

//{
//    "images": [
//    "http://pic3.zhimg.com/631d4f6f27ef25ebc7fd58bf52a42cb2.jpg"
//    ],
//    "type": 0,
//    "id": 8651658,
//    "ga_prefix": "080514",
//    "title": "那个「英雄主义」的 NBA，还有他在坚守"
//}

class Story: NSObject,Mappable {
    
    var type:Int?
    var id:Int?
    var ga_prefix:String?
    var title:String?
    var images:[String]?
    
    required init?(_ map: Map) {
        
    }
    //匹配规则
    // map 可以理解为要解析的json 数据
    func mapping(map: Map) {
        self.type <- map["type"]
        self.id <- map["id"]
        self.ga_prefix <- map["ga_prefix"]
        self.title <- map["title"]
        self.images <- map["images"]
    }
}

