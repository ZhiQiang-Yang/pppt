//
//  HotViewController.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/4.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

// 协议名要放在父类名的后面,用 , 隔开
class HotViewController: UIViewController,UITableViewDataSource {
    //加标签
    // MARK:  TEST
    
    
    //通过闭包创建UI控件
    let tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRectMake(0, 0, 200, 600), style: UITableViewStyle.Plain)
        // swift 中通过 类型名.self 来返回类型名
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.registerNib(UINib(nibName: "HotCell", bundle: nil), forCellReuseIdentifier: "hotcell")
        return table
    }()
    
    //计算属性
    var frame:CGRect{
        get{
           return self.view.bounds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.frame = frame
        
        //设置tableview 的行高是自动计算的
        // 使用这个方法的话就不需要再 tableview的返回高度的回调方法了
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        //注册可视化的cell
        
        view.addSubview(tableView)
        
        //发起网络请求
        //网络请求管理实例
        let manager = NetworkManager.sharedManager
        //利用网络请求实例来发起网络请求
        manager.fetchTopics {
            //网络请求成功后就执行这行代码
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NetworkManager.sharedManager.topics.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //查找复用的cell
        let cell = tableView.dequeueReusableCellWithIdentifier("hotcell", forIndexPath: indexPath) as? HotCell
        
        let topic = NetworkManager.sharedManager.topics[indexPath.row]
        
        cell!.topic = topic
        
        return cell!
    }

}
