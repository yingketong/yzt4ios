//
//  PatientController.swift
//  YiYou
//
//  Created by JasonFu on 15-1-20.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import  UIKit

class HomePageController: UITableViewController{
    
    var list = NSMutableArray()
    var refresh = UIRefreshControl()

//
//    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
//        self.performSegueWithIdentifier("aa", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var item : NSDictionary = NSDictionary(objects:["http://imgsrc.baidu.com/forum/w%3D580/sign=5a4e33b7d4ca7bcb7d7bc7278e096b3f/29c8ca1b0ef41bd5852ee28052da81cb38db3d9e.jpg","公告", "2015新年放假公告:2015新年放假公告",(NSDate().description as NSString).substringToIndex(19)]
            ,forKeys: ["img","title","subTitle","date"])
        list.addObject(item)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //设置左边编辑，右边添加item
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        self.setExtraCellLineHidden(tableView)
        
        //添加刷新
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "下拉即可刷新")
        tableView.addSubview(refresh)
       
    }

    // 刷新数据
    func refreshData() {
        var item : NSDictionary = NSDictionary(objects:["http://imgsrc.baidu.com/forum/w%3D580/sign=6d34407a6409c93d07f20effaf3df8bb/8d2fcf2a6059252d70091770379b033b5ab5b9fa.jpg","庞麦郎", "医生早上好！医生再见！","10-01"] , forKeys: ["img","title","subTitle","date"])
        list.addObject(item)
        self.tableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    func insertNewObject(sender: AnyObject) {
         var item : NSDictionary = NSDictionary(objects:["http://imgsrc.baidu.com/forum/w%3D580/sign=6d34407a6409c93d07f20effaf3df8bb/8d2fcf2a6059252d70091770379b033b5ab5b9fa.jpg","庞麦郎", "医生早上好！医生再见！","10-01"] , forKeys: ["img","title","subTitle","date"])
        list.insertObject(item, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
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
        let cellIdentifier : String = "homePageCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as HomePageCell
        var row = indexPath.row
        var rowDict : NSDictionary = list.objectAtIndex(row) as NSDictionary
        let url : String = rowDict.objectForKey("img") as String
        let dataImg : NSData = NSData(contentsOfURL: NSURL(string : url)!)!
        cell.Img.image = UIImage(data: dataImg)
        cell.Title.text = rowDict.objectForKey("title") as? String
        cell.SubTitle.text = rowDict.objectForKey("subTitle") as? String
        cell.Date.text = rowDict.objectForKey("date") as? String
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // 支持单元格编辑功能
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // 单元格编辑
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {//删除单元格
            list.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // 单元格排序
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        if fromIndexPath != toIndexPath{
            var object: AnyObject = list.objectAtIndex(fromIndexPath.row)
            list.removeObjectAtIndex(fromIndexPath.row)
            if toIndexPath.row > self.list.count{
                self.list.addObject(object)
            }else{
                self.list.insertObject(object, atIndex: toIndexPath.row)
            }
        }
    }
    
    //在编辑状态，可以拖动设置item位置
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }
    
    
    //隐藏多余分割线
    func setExtraCellLineHidden(tableView:UITableView){
        var view = UIView()
        view.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = view
    }

    // MARK: - Navigation
    
    //给新进入的界面进行传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object : NSDictionary = list[indexPath.row] as NSDictionary
                (segue.destinationViewController as ConversationController).detailItem = object
            }
        }
    }
}