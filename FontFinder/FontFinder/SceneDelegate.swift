//
//  SceneDelegate.swift
//  FontFiner
//
//  Created by JURA on 2020/02/29.
//  Copyright © 2020 jura. All rights reserved.
//

import UIKit
import RealmSwift
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    

    var window: UIWindow?
    
    var realm: Realm!
    var allData: AllDataModel!
    var dataRealm: RealmDBModel!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let emailViewController = EmailViewController()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible() //화면에서 키보드를 입력 받을 수 있게하는 코드
        window?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        window?.rootViewController = UINavigationController(rootViewController: emailViewController)
        window?.rootViewController?.navigationController?.isNavigationBarHidden = true
        
        
        //statusbar height size
        IOSInfo.statusbar = Int(window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        IOSInfo.screenWidth = Int(UIScreen.main.bounds.width)
        IOSInfo.screenHeight = Int(UIScreen.main.bounds.height)
        
        
        
        //Appdelegate data share
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        self.allData = appDelegate.allData
        self.realm = appDelegate.realm
        self.dataRealm = appDelegate.dataRealm
        
        
        //EmailVIewController data share
        emailViewController.allData = self.allData
        
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

