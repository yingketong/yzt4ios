//
//  ReportController.swift
//  yzt4ios
//
//  Created by JasonFu on 15-1-22.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit

class ReportController: UITableViewController{
    
    var list = NSMutableArray()
    var refresh = UIRefreshControl()
    
    //
    //    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
    //        self.performSegueWithIdentifier("aa", sender: self)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let alertview = UIAlertView();
        alertview.title = "当前网络不可用，请检查网络连接!";
        if ReachabilityType.isConnectedToNetwork() {
            initData();
        } else {
            alertview.show();
        }
        
        //添加刷新
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉即可刷新")
        tableView.addSubview(refresh)
    }
    
    func initData(){
        var dic1 = ["img":"http://imgsrc.baidu.com/forum/w%3D580/sign=6d34407a6409c93d07f20effaf3df8bb/8d2fcf2a6059252d70091770379b033b5ab5b9fa.jpg","title":"待办","subTitle":"123","date":(NSDate().description as NSString).substringToIndex(19)];
        var dic2 : NSDictionary = NSDictionary(objects:["http://imgsrc.baidu.com/forum/w%3D580/sign=5a4e33b7d4ca7bcb7d7bc7278e096b3f/29c8ca1b0ef41bd5852ee28052da81cb38db3d9e.jpg","公告"]
            ,forKeys: ["img","title"])
        list.addObject(dic2)
        list.addObject(dic1);
        self.setExtraCellLineHidden(tableView)

    }
    
    // MARK: - Table view data source
    
    //返回节的个数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //返回某个节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //为表视图单元格提供数据，该方法是必须实现的方法
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier : String = "reportCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as ReportCell
        var row = indexPath.row
        var rowDict : NSDictionary = list.objectAtIndex(row) as NSDictionary
        let url : String = rowDict.objectForKey("img") as String
        let dataImg : NSData = NSData(contentsOfURL: NSURL(string : url)!)!
        cell.Img.image = UIImage(data: dataImg)
        cell.Title.text = rowDict.objectForKey("title") as? String
//        cell.SubTitle.text = rowDict.objectForKey("subTitle") as? String
//        cell.Date.text = rowDict.objectForKey("date") as? String
        return cell
        
    }
    //隐藏多余分割线
    func setExtraCellLineHidden(tableView:UITableView){
        var view = UIView()
        view.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = view
    }

    // 刷新数据
    func refreshData() {
        if refresh.refreshing {
            refresh.attributedTitle = NSAttributedString(string: "正在刷新")
            }
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    sleep(1)
                    self.refresh.endRefreshing()
                    self.refresh.attributedTitle = NSAttributedString(string: "下拉即可刷新")
                    self.tableView.reloadData()
                })
        })
    }
}


