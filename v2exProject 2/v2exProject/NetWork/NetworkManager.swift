//
//  NetworkManager.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/4.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Alamofire

enum NetWorkError {
    case NotFound
    case NoNet
}
enum DataError:ErrorType {
    case TranError
    case NilError
}
enum NetAPI:String {
    case Hot = "topics/latest.json"
    case Nodes = "nodes/all.json"
    case node = "nodes/show.json"
}

//单例 -> 产生全局只有一份的一个对象,这个对象只有才程序退出时才会消失

/// 网络管理单例类
class NetworkManager: NSObject {
    
    //创建一个空数组,用来存储数据
    var topics:[Topic] = [Topic]()
    private let baseURL = "https://www.v2ex.com/api/"
    
    //通过类型属性来实现单例
    // let/var 修饰是常量还是变量
    // (static|class)  修饰是否是类型属性
    // 不可变类属性
    static let sharedManager = NetworkManager()
    
    /**
     请求最新的topic 数据
     */
    func fetchTopics(success:()->()) {
        // success 是闭包的名字
        let session = NSURLSession.sharedSession()
        //创建一个请求
        let url = NSURL(string: "https://www.v2ex.com/api/topics/latest.json")
        let request = NSURLRequest(URL: url!)
                //配置网络请求
        let task = session.dataTaskWithRequest(request) { (data, reponse, error) in
            if error != nil {
                print(error)
                return
            }
            do {
            //do catch
            //执行do 中的代码,如果执行失败.就执行catch 中的代码
            
                //try
                //将data 解析成json(字典)
                //NSJSONSerialization
                let t:AnyObject? = try?  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                if t == nil {
                    throw DataError.TranError
                }
                // json 解析出来的是Anyobject
                // anyobject -> NSArray -> Array?
                // AnyObject 如何转成 Array ?
                let array = (t as? NSArray) as Array?
                
                if array == nil {
                    throw DataError.TranError
                }
                
                for dic in array! {
                    let topic = Topic()
                    //因为没有办法推断出Array 数组中存的字典是什么类型的,所以强转是要指定字典数据类型
                    topic.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    //添加到数组中去
                    self.topics.append(topic)
                }
                //数据解析完成,执行回调闭包
                if NSThread.isMainThread() {
                    success()
                }else{
                    dispatch_async(dispatch_get_main_queue(), { 
                        success()
                    })
                }
                
            }catch{
                print("解析json失败")
            }
            print(data)
        }
        
        //开始网络请求
        task.resume()
       
    }
    
    
    func fetchDataByAlamofire(api:NetAPI,parameters:[String:AnyObject], success:(value:AnyObject)->()) -> Void {
        Alamofire.request(.GET, "https://www.v2ex.com/api/" + api.rawValue).responseJSON { (request, response, result) -> Void in
            switch result {
            case let .Success(result):
                success(value: result)
            case let .Failure(error):
                print(error)
            }
        }
//        Alamofire.request(.GET,"https://www.v2ex.com/api/" + api.rawValue, parameters: parameters).responseJSON { (response:Response) in
//            switch response.result {
//            case let .Success(result):
//                success(value: result)
//            case let .Failure(error):
//                print(error)
//            }
//        }
    }
    
    
}
