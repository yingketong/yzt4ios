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
    var progressView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ReachabilityType.isConnectedToNetwork() {
            initData();
            self.setExtraCellLineHidden(tableView)
        } else {
            alert();
        }
        //添加刷新
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉即可刷新")
        tableView.addSubview(refresh)
        progressView.frame = CGRectMake(0, 0,100,100)
        progressView.center = self.view.center
        progressView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        progressView.startAnimating()
        self.view.addSubview(progressView)
        
    }
    
    func initData(){
        var urlString = "http://10.87.66.209:8080/appServer/model/kpi/list.json?limit=20&start=0&page=1&orgId=2"
        let request = YYHRequest(url: NSURL(string: urlString)!)
        
        request.loadWithCompletion { response, data, error in
            if data != nil {
                var error : NSError?
                let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary!
                if (jsonData == nil || error != nil){
                    println("error: \(error)")
                }
                let resultArray = jsonData.objectForKey("result") as NSArray!
                for var i = 0 ; i<resultArray.count ;i++ {
                    self.list.addObject(resultArray[i])
                }
                self.tableView.reloadData()
                println("response: \(jsonData)")
            }
        }
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
        let imgUrl : String = rowDict.objectForKey("kpiIconUrl") as String
        let dataImg : NSData = NSData(contentsOfURL: NSURL(string : "http://211.95.5.70/appServer/"+imgUrl)!)!
        cell.Img.image = UIImage(data: dataImg)
        cell.Title.text = rowDict.objectForKey("kpiName") as? String
        progressView.removeFromSuperview()
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
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            var indexPath : NSIndexPath = tableView.indexPathForSelectedRow()!
            var row = indexPath.row
            var rowDict : NSDictionary = list.objectAtIndex(row) as NSDictionary
            if segue.identifier == "showReport" {
                (segue.destinationViewController as WebController).object = rowDict.objectForKey("kpiUrl") as String
                (segue.destinationViewController as WebController).titleString = rowDict.objectForKey("kpiName") as String
            }
    }
    
    func alert(){
        var alertview = UIAlertView();
        alertview.title = "出错!"
        alertview.delegate = self
        alertview.message = "当前网络不可用，请检查网络连接!";
        alertview.addButtonWithTitle("确定")
        alertview.show();
    }
}


