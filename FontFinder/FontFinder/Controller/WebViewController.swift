//
//  WebViewController.swift
//  FontFiner
//YTGGGTTBVVV VVV
//  Created by JURA on 2020/03/01.
//  Copyright © 2020 jura. All rights reserved.
//

//webView 사용:  Info.plist
//App Transport Security Setting >> Allow Arbitrary Loads:YES
import WebKit
import UIKit
import RealmSwift
import Alamofire
//https://m.blog.naver.com/PostView.nhn?blogId=scw0531&logNo=221683538588&proxyReferer=https%3A%2F%2Fwww.google.com%2F
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    var uiViews: UIViewS!
    var webView: WKWebView!
    var allData: AllDataModel!
    var emailUiViews: UIViewS!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiViews = UIViewS(frame: self.view.frame)
        uiViews.commonInit("web")
        view = uiViews
        cashDelete()
        
        
        initWebView_then_callFromJS()
        loadURL()
        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barStyle = .black
        

        
//        checkNetworkConnect()
        
    }
    let config = WKWebViewConfiguration()
    func initWebView_then_callFromJS() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "sendEmailName")
        config.userContentController = contentController
        
    }
    func loadURL() {
        
        print(view.bounds.width)
        print(view.frame.height)
        print(view.frame.height/10 * 9)
        webView = WKWebView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: view.frame.height), configuration: config)//view.frame.height - view.frame.height/10
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        uiViews.webViewIn.addSubview(webView)
            
        
        let myURL = URL(string:"http://hegs3.ipdisk.co.kr:8080/Font/")
        
        var myRequest = URLRequest(url: myURL!)
//        var cookies = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies(for: myRequest.url!)!)
        let cookieValue = "email=\(allData.emailDataUnwrappedGet());name=\(allData.nameDataUnwrappedGet());uuid=\(allData.uuidDataUnwrappedGet());"
        myRequest.setValue(cookieValue, forHTTPHeaderField: "Cookie")
        print(myRequest.allHTTPHeaderFields!)
        
        webView.load(myRequest)
    }
   
    //WKUIDelegate
    //cashdata delete
    func cashDelete() {
        let websiteDataType = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeCookies])
        let date = NSDate(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataType as! Set, modifiedSince: date as Date, completionHandler: { })
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {
            (records) -> Void in
            for records in records{
                WKWebsiteDataStore.default().removeData(ofTypes: records.dataTypes, for: [records], completionHandler: {})
            }
        })
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    // MARK: -  WKUIDelegate
    // MARK: -  WKNavigationDelegate
    
    //navigation
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
//        naviBtnInit()
        
        let requestURL = navigationAction.request.url?.absoluteString
        let strScheme = navigationAction.request.url?.scheme
        if strScheme != "http" || strScheme != "https" || strScheme != "file"{
            openScheme(strUrl:requestURL!)
        }
        decisionHandler(.allow)
        
    }
    
    func openScheme(strUrl : String){
        let decodeUrl = strUrl.removingPercentEncoding
        
        var strUrlScheme = decodeUrl
        if strUrlScheme?.hasPrefix(UrlInfo.schemeName) == true {
            strUrlScheme = strUrlScheme?.replacingOccurrences(of: UrlInfo.schemeName, with: "")
            
//            if strUrlScheme == "load_setting" {
//                if let settingViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingView"){
//                    settingViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//                    self.present(settingViewController, animated: true)
//                }
//            }
            print(strUrlScheme!)
            if strUrlScheme == "logout" {
                
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                emailUiViews.nameTextView.text = allData.nameDataUnwrappedGet()
                emailUiViews.emailTextView.text = allData.emailDataUnwrappedGet()
                return
            }
            if strUrlScheme == "setting" {
                let settingViewController = SettingViewController()
                if #available(iOS 13.0, *) {
                    settingViewController.modalPresentationStyle = .automatic
                } else {
                    settingViewController.modalPresentationStyle = .fullScreen
                }
                self.present(settingViewController, animated: true)
                return
            }
        }
    }
    

    
    // MARK: - alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        self.present(alertController, animated: true, completion: nil) }

    // MARK: - confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    // MARK: confirm 처리2
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in textField.text = defaultText }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in if let text = alertController.textFields?.first?.text { completionHandler(text) } else { completionHandler(defaultText) } }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(nil) }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request
            )
        }
        return nil
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var receivedData:String!
        if (message.name == "sendEmailName") {
            
            
            receivedData = message.body as? String
            
            let json = """
                \(receivedData!)
                """.data(using: .utf8)!
            print(json)
            let decoder = JSONDecoder()
            let modifedData = try! decoder.decode(InitialData.self, from: json)
            
            allData.emailInputData(emailOpt: modifedData.email)
            allData.nameInputData(nameOpt: modifedData.name)
        }
    }
    
}
