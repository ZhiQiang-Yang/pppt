//
//  NewsViewController.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/5.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit // autolayou库
import ObjectMapper
//MJextence ,JsonModel,YYModel

class NewsViewController: UIViewController {

    
    var  news:[Story]?
    
    
    var tableView:UITableView = UITableView(frame: CGRectZero, style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        fetchData()
    }
    func customUI() {
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "NewCell", bundle: nil)
        
        tableView.registerNib(nib, forCellReuseIdentifier: "newcell")
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
    }
    func  fetchData() {
        let manager = ZhihuNetworkManager()
        manager.fetchData(ZhihuAPI.New, success: { (value) in
//            print(value)
            let json = value as! NSDictionary
//            print(json["date"])
            let stores = json["stories"]
//            let topStores = json["top_stories"]
            
            // Mapper -> 解析器(负责讲dic 转成 model)
            // 需要制定 转成那个model
            //stores [[name:zs,age:23],{},{}...]
            let mapTool = Mapper<Story>()
            // mapTool 是一个制定了要转成什么模型的转换器
            self.news = mapTool.mapArray(stores)
            //通过转换器进行转换
//            [name:zs,age:23]
            //下面是单个字典转换
//            let s = mapTool.map(stores![0])
//            print(s)
            
//            array  [Story(),Story(),Story().....]
            
            self.tableView.reloadData()
            },failure:{ (message) in
                print(message)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension  NewsViewController:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news == nil ? 0 : (self.news?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("newcell", forIndexPath: indexPath) as? NewCell
        
        cell?.story = news![indexPath.row]
        return cell!
    }
}
