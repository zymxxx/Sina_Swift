//
//  OauthViewController.swift
//  Sina_Swift
//
//  Created by zym on 15/12/28.
//  Copyright © 2015年 zym. All rights reserved.
//

import UIKit

class OauthViewController: UIViewController,UIWebViewDelegate {

    var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView)
        
        var oauthString: String = "https://api.weibo.com/oauth2/authorize?"
        oauthString += "client_id=\(APP_KEY)"
        oauthString += "&response_type=code"
        oauthString += "&redirect_uri=https://github.com/TheSolitary"
        oauthString += "&dispaly=mobile"
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: oauthString)!))
        webView.delegate = self;
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.URL?.absoluteString.rangeOfString("code=") != nil{
            let code = request.URL?.query?.componentsSeparatedByString("=")[1]
            HttpManager.getAccesstoken(code!)
        }
        
        return true;
    }

}
