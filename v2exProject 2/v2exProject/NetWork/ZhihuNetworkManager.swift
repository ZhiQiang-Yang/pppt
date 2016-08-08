//
//  ZhihuNetworkManager.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/5.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Alamofire

enum ZhihuAPI:String {
    case New = "4/news/latest"
}
class ZhihuNetworkManager: NSObject {

    let baseURL:String = "http://news-at.zhihu.com/api/"
    
    func fetchData(api:ZhihuAPI,success:(value:AnyObject)->(),failure:(message:String)->()) {
        Alamofire.request(.GET, (baseURL + api.rawValue),parameters: [:]).responseJSON { (request,response,result) in
            //response 就是网络请求成功并且解析完成之后返回给我们的结果
//            let result = response.result
            //response.result -> (Result,枚举) success file
            switch result {
                //值绑定
            case let .Success(value):// anyobject
                print(value)
                success(value: value)
            case let .Failure(error):
//                print(error)
                failure(message: "请求数据或者解析数据失败")
            }
        }
    }
    
    
    
}
