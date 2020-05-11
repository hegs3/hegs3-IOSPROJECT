//
//  AppDelegate.swift
//  TagPicture
//
//  Created by JURA on 2019. 3. 19..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit
    // Todo: http://blog.naver.com/PostView.nhn?blogId=writer0713&logNo=221040662262&redirect=Dlog&widgetTypeCall=true
    // Todo:    https://www.clien.net/service/board/cm_app/11084600
    // Todo:    http://blog.naver.com/PostView.nhn?blogId=scw0531&logNo=221142873555&parentCategoryNo=&categoryNo=23&viewDate=&isShowPopularPosts=true&from=search
    // Todo:    https://okky.kr/article/460212
    // Todo: https://beankhan.tistory.com/202

    // 위에것과 비교
    // Todo: https://soulpark.wordpress.com/2014/05var/is-there-way-to-check-if-app-is-installed-when-sending-a-push-notification/

    //가장 최근
    // Todo: https://codeday.me/ko/qa/20190403/228320.html
    // Todo: https://stackoverrun.com/ko/q/11251304

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    var window: UIWindow?
    
    var tagStore = TagStore()
    var photoStore = PhotoStore()
    var sqlConnect = SQLConnect()
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let navController = window!.rootViewController as! UINavigationController
        let mainViewController = navController.topViewController as! MainViewController
        
        mainViewController.sqlConnect = sqlConnect
        mainViewController.photoStore = photoStore
        mainViewController.tagStore = tagStore
        
        self.sqlConnect.tagStore = tagStore
        self.sqlConnect.verification()  //uuid 생성 및 날짜 update , 동일uuid 검증//sql데이터 가져오기
        
        
//        let tableViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.init(red: 75/255.0, green: 134/255.0, blue: 175/255.0, alpha: 1)
        let img = UIImage()
        navController.navigationBar.shadowImage = img
        navController.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navController.navigationBar.backgroundColor = UIColor.init(red: 75/255.0, green: 134/255.0, blue: 175/255.0, alpha: 1)
        navController.navigationBar.isTranslucent = true
        
        
    
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

