//
//  HttpManager.swift
//  ZhiHu_Swift
//
//  Created by zym on 15/12/25.
//  Copyright © 2015年 zym. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let APP_KEY = "1683370155"
let APP_SECRET = "63f795ff3ccf3b2bfcbd825a21e001ee"
let REDIRECT_URL = "https://github.com/TheSolitary"
let ACCESS_TOKEN = "2.00Hy6MWDXTPvpBdac11ca5fe07VXEa"

private let access_token_url = "https://api.weibo.com/oauth2/access_token?"
private let status_friend_timeline = "https://api.weibo.com/2/statuses/friends_timeline.json"

class HttpManager{
    
    class func getAccesstoken(code: String) -> Void{
        
        let params = ["client_id":APP_KEY,
        "client_secret":APP_SECRET,
        "grant_type":"authorization_code",
        "code":code,
        "redirect_uri":REDIRECT_URL]
        
        Alamofire.request(.POST, access_token_url, parameters: params).responseJSON { response in
            print(response)
        }
    }
    
    //获取当前登录用户及其所关注（授权）用户的最新微博
    class func getStatus_friend_timeline(since_id: Int, max_id: Int, count: Int, feature: Int, callback: [StatusModel] -> Void) -> Void{
        
        let params: [String: AnyObject] = ["source": APP_KEY,
            "access_token": ACCESS_TOKEN,
            "since_id": since_id,
            "max_id": max_id,
            "count": count,
            "base_app": 0,
            "feature": feature,
            "trim_user": 0]
        
        Alamofire.request(.GET, status_friend_timeline, parameters: params).responseJSON { response in
            dispatch_async(dispatch_get_global_queue(0, 0), {print(response)})
            let jsonData = JSON(data: response.data!)
            let statusesJSON = jsonData["statuses"]
            var result: [StatusModel] = []
            for statusJSON: JSON in statusesJSON.arrayValue{
                var statusModel = StatusModel()
                statusModel.transformModelFromJSON(statusJSON)
                result.append(statusModel)
            }
            callback(result)
        }
    }
}
