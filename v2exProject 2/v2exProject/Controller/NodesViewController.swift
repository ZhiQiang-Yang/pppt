//
//  NodesViewController.swift
//  v2exProject
//
//  Created by 郑建文 on 16/8/4.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper

class NodesViewController: UIViewController {

    var tableView:UITableView = {
        let table = UITableView(frame: CGRectZero, style: .Plain)
        table.registerNib(UINib(nibName:"NodeCell",bundle: nil), forCellReuseIdentifier: "cell")
        return table
    }()
    
    var array:Array<Node>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        fetchData()
    }
    func customUI()  {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
        }
    }
    func fetchData() {
        NetworkManager.sharedManager.fetchDataByAlamofire(NetAPI.Nodes,parameters: [:]) { (value) in
            self.array = Mapper<Node>().mapArray(value)
            self.tableView.reloadData()
        }
    }
}
extension NodesViewController:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (array?.count) ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? NodeCell
        cell?.node = array![indexPath.row]
        return cell!
    }
}
