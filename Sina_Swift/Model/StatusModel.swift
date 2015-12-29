//
//  StatusModel.swift
//  Sina_Swift
//
//  Created by zym on 15/12/28.
//  Copyright © 2015年 zym. All rights reserved.
//

import Foundation
import SwiftyJSON

struct StatusModel{
    var created_at: String?
    var id: Int?
    var mid: Int?
    var idstr: String?
    var text: String?
    var source: String?
    var favorited: Bool?
    var truncated: Bool?
    var in_reply_to_status_id: String?
    var in_reply_to_user_id: String?
    var in_reply_to_screen_name: String?
    var thumbnail_pic: String?
    var bmiddle_pic: String?
    var original_pic: String?
    var retweeted_status: Int?
    var reposts_count: Int?
    var comments_count: Int?
    var attitudes_count: Int?
    var pic_ids: [String: String]?
    
    mutating func transformModelFromJSON(json: JSON){
        self.created_at = json["created_at"].stringValue
        self.text = json["text"].stringValue
        self.id = json["id"].int
        self.mid = json["mid"].int
        self.source = json["source"].stringValue
        self.favorited = json["favorited"].bool
        self.truncated = json["truncated"].bool
    }
}
