//
//  HomeViewController.swift
//  Sina_Swift
//
//  Created by zym on 15/12/28.
//  Copyright © 2015年 zym. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var homeTable: UITableView!
    var dataSource = [StatusModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeTable.mj_header = THCircleRefreshHeader(refreshingTarget: self, refreshingAction: "refreshHandler")
        self.homeTable.registerNib(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: NSStringFromClass(StatusCell.self))
        self.homeTable.estimatedRowHeight = 88.0
        self.homeTable.rowHeight = UITableViewAutomaticDimension
        self.homeTable.dataSource = self
        self.homeTable.delegate = self
        self.homeTable.mj_header.beginRefreshing()
        
    }
    

    func refreshHandler() {
        HttpManager.getStatus_friend_timeline(0, max_id: 0, count: 200, feature: 0) { result in
            self.dataSource = result
            self.homeTable.mj_header.endRefreshing()
            self.homeTable.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(StatusCell.self), forIndexPath: indexPath) as! StatusCell
        let statusModel = self.dataSource[indexPath.row]
        cell.selectionStyle = .None
        cell.setStatusString(statusModel.text!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
}
