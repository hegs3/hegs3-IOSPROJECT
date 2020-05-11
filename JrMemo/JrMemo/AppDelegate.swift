//
//  AppDelegate.swift
//  JrMemo
//
//  Created by JURA on 2018. 12. 30..
//  Copyright © 2018년 jura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var folderItemStore = FolderItemStore()
    let subjectItemStore = SubjectItemStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: imageStore property

        // MARK: Controller property
        let navController = window!.rootViewController as! UINavigationController
        let folderViewController = navController.topViewController as! FolderViewController
        
        let subjectViewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "subjectSegue") as! SubjectTableViewController
        // MARK: Statusbar & NavigationBar custom
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        statusBar?.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        let img = UIImage()
        navController.navigationBar.shadowImage = img
        navController.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navController.navigationBar.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.8)
        navController.navigationBar.isTranslucent = true

        
        // MARK: toobar custom
        navController.toolbar.setBackgroundImage(img, forToolbarPosition: UIBarPosition.bottom, barMetrics: UIBarMetrics.default)
        navController.toolbar.setShadowImage(img, forToolbarPosition: UIBarPosition.bottom)
        navController.toolbar.isTranslucent = true
        
        
        folderViewController.folderItemStore = folderItemStore
        subjectViewController.subjectDatasource.subjectItemStore = subjectItemStore
        
        let imageStore = ImageStore()
        folderViewController.imageStore = imageStore

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //MARK: DATA SAVE & save state log
        let successF = folderItemStore.saveChanges()
        let successS = subjectItemStore.saveChanges()
        if (successF) {
            print("F SAVE SUCCESS")
        } else {
            print("F SAVE FAIL")
        }
        if (successS) {
            print("S SAVE SUCCESS")
        } else {
            print("S SAVE FAIL")
        }
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

