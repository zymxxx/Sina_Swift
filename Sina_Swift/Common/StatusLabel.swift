//
//  StatusLabel.swift
//  Sina_Swift
//
//  Created by zym on 15/12/29.
//  Copyright © 2015年 zym. All rights reserved.
//

import UIKit
import YYText

class StatusLabel: YYLabel {
    override var text: String!{
        get{
            return super.text
        }
        set{
            super.text = newValue;
//            self.statusTextToAttibuted(super.text!)
        }
    }
}
