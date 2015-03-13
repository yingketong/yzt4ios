//
//  JieDetailViewController.swift
//  YiYou
//
//  Created by JasonFu on 15-1-20.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//

import UIKit

class ConversationController: UIViewController {
    
    
    @IBOutlet var big_video_img: UIImageView!
    //接受传进来的值
    var detailItem: NSDictionary?
    
    
    func configureView() {
        if let detail : NSDictionary = self.detailItem {
            self.title = detail.objectForKey("title") as? String
            let url : String = detail.objectForKey("img") as String
            let dataImg : NSData = NSData(contentsOfURL: NSURL(string : url)!)!
            self.big_video_img.image = UIImage(data: dataImg)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
    }
    
}