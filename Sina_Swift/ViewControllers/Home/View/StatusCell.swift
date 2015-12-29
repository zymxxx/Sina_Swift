//
//  StatusCell.swift
//  Sina_Swift
//
//  Created by zym on 15/12/28.
//  Copyright © 2015年 zym. All rights reserved.
//

import UIKit
import YYText

var URL_REGULAR = "(%s*r)+|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)"
var TOPIC_REGULAR = "#[^#]+#"
var ACCOUNT_REGULAR = "(@([\\u4e00-\\u9fa5A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)._-]+))"


class StatusCell: UITableViewCell {

    @IBOutlet weak var statusText: YYLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusText.numberOfLines = 0
    }
    func setStatusString(text: String){
        let statusString = NSMutableAttributedString(string: text)
        statusString.yy_font = UIFont.systemFontOfSize(17)
        
        let highlight = YYTextHighlight(attributes: nil)
        highlight.setColor(UIColor.redColor())
        highlight.tapAction = {view, text, range, rect in
        
        }
        let regex = try! NSRegularExpression(pattern: URL_REGULAR, options: .CaseInsensitive)
        let mathes = regex.matchesInString(text,
            options: NSMatchingOptions.ReportProgress,
            range: statusString.yy_rangeOfAll())
        
        for result in mathes {
            statusString.addAttributes([NSFontAttributeName : UIFont.systemFontOfSize(17),
                NSForegroundColorAttributeName : UIColor(red: 155/255.0, green: 89/255.0, blue: 182/255.0, alpha: 1)],
                range: result.range)
            statusString.yy_setTextHighlight(highlight, range: result.range)

        }
        self.statusText.attributedText = statusString;
        let size = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 26, CGFloat.max)
        let layout = YYTextLayout(containerSize: size, text: statusString)
        self.statusText.frame = layout.textBoundingRect
        self.statusText.textLayout = layout
        
    }
    
}
