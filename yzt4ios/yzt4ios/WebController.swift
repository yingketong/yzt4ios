//
//  WebController.swift
//  yzt4ios
//
//  Created by JasonFu on 15-3-24.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit


class WebController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webViews: UIWebView!
    //接受传进来的值
    var object: NSString?
    var titleString: NSString?

    @IBOutlet weak var progBar: UIProgressView!
    //进度条计时器
    var ptimer:NSTimer!
    
    @IBOutlet weak var nav: UINavigationItem!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.webViews.delegate = self;
        nav.title = titleString
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor();
        
        // 设置该进度条的初始进度为0
        progBar.progress = 0
        
        // 创建使用 UIView 的自定义的 UIBarButtonItem
        var btnprog =  UIBarButtonItem(customView:progBar)
        //创建计时器对象
        ptimer = NSTimer.scheduledTimerWithTimeInterval(0.2,
            target:self ,selector: Selector("loadProgress"),
            userInfo:nil,repeats:true);
        ptimer.invalidate()
        
        var detailUrl = NSURL(string: self.object!)
        var request = NSURLRequest(URL: detailUrl!)
        webViews.loadRequest(request)
  
    }
    
    func webViewDidStartLoad(webView:UIWebView)
    {
        progBar.setProgress(0, animated:false);
        ptimer.fire();
    }
    
    func webViewDidFinishLoad(webView:UIWebView)
    {
        progBar.setProgress(1, animated:true);
        ptimer.invalidate();
    }
    
    func loadProgress()
    {
        // 如果进度满了，停止计时器
        if(progBar.progress >= 1.0){
            // 停用计时器
            ptimer.invalidate();
        }else{
            // 改变进度条的进度值
            progBar.setProgress(progBar.progress + 0.02, animated:true);
        }
    }
    
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!)
    {
        var alertview = UIAlertView();
        alertview.title = "出错!"
        alertview.delegate = self
        alertview.message = error.localizedDescription;
        alertview.addButtonWithTitle("确定")
        alertview.show();
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}