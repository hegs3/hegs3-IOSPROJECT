//
//  AppConfig.swift
//  mastercms
//
//  Created by Ami Systems on 18/09/2019.
//  Copyright © 2019 amisystems. All rights reserved.
//

import Foundation

struct UrlInfo {
    
//    static var AppName:String = " Amicms"
    
//    static var API_VERSION:String  = "/v2"
//    static var CENTER_API_VERSION:String = "/v3"
    static var schemeName:String = "fontfinder://"
    static var API_OS:String  = "ios"
    
    // Main
    static var MAIN_URL:String = "http://hegs3.ipdisk.co.kr"


    
//    static var API_CENTER_MAIN:String = "http://v.app.amicms.co.kr"
//    static var API_HEADER:String = "/api"
//    static var API_GET_APP_VERSION:String = API_CENTER_MAIN + API_HEADER + CENTER_API_VERSION + "/get_app_version"
    
    // PUSH API
//    static var API_REGIST_TOKEN:String = API_HEADER + API_VERSION + "/regist_token"
//    static var API_GET_PUSH_SETTING:String = API_HEADER + API_VERSION + "/get_push_setting"
//    static var API_MODIFY_PUSH_SETTING:String = API_HEADER + API_VERSION + "/modify_push_setting";
//    static var API_MODIFY_NIGHT_PUSH_SETTING:String = API_HEADER + API_VERSION + "/modify_night_push_setting";
    
    // JWT Token
//    static var API_LOGIN:String = API_HEADER + API_VERSION + "/login"
//    static var API_TOKEN_REFRESH:String = API_HEADER + API_VERSION + "/token/refresh"
    
    // Cookie AppType
//    static var COOKIE_APP_TYPE_KEY:String = "AMI_APPTYPE"
//    static var COOKIE_APP_TYPE_VALUE:String = COOKIE_APP_TYPE_KEY + "=ios"
    
    // First Page
    static var PAGE_INDEX:String = "/index.php"
//    static var PAGE_LIST:String = "/newsroom/article/list?menuCode=0103"
//    static var PAGE_DESK:String = "/newsdesk/article/list?menuCode=0201"
    
}
struct IOSInfo {
    //statusbar
    static var statusbar: Int = 0
    
    //screenSize
    static var screenWidth: Int = 0
    static var screenHeight: Int = 0
}
