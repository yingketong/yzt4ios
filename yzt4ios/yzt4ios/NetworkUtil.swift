//
//  NetworkUtil.swift
//  yzt4ios
//
//  Created by JasonFu on 15-3-27.
//  Copyright (c) 2015年 JasonFu. All rights reserved.
//
import Foundation

public class NetworkUtil{
    
   public class func httpGet(urlString:String, params:Dictionary<String,AnyObject>?) ->NSDictionary!{
    var result : NSDictionary!
    var request = HTTPTask()
    request.GET(urlString, parameters: params, success: {(response: HTTPResponse) -> Void in
        if response.responseObject != nil {
            let data = response.responseObject as NSData
            var error : NSError?
            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary!
            if (jsonData == nil || error != nil){
                println("error: \(error)") //prints the HTML of the page
            }
            result = jsonData
            println("response: \(jsonData)") //prints the HTML of the page
        }
        },failure: {(error: NSError,response: HTTPResponse?) -> Void in
            println("error: \(error)")
    })
    return result
    }


    public class func httpPost(urlString:String, params:Dictionary<String,AnyObject>?){
        var request = HTTPTask()
        request.POST("http://domain.com/create", parameters: params, success: {(response: HTTPResponse) -> Void in
            if response.responseObject != nil {
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError,response: HTTPResponse?) -> Void in
                println("error: \(error)")
        })
    }
    
}