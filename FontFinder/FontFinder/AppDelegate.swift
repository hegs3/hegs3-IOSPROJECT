//
//  AppDelegate.swift
//  FontFiner
//
//  Created by JURA on 2020/02/29.
//  Copyright © 2020 jura. All rights reserved.
//


//1. 앱의 가장 중요한 데이터 구조를 초기화하는 것
//2. 앱의 scene을 환경설정(Configuration)하는 것
//3. 앱 밖에서 발생한 알림(배터리 부족, 다운로드 완료 등)에 대응하는 것
//4. 특정한 scenes, views, view controllers에 한정되지 않고 앱 자체를 타겟하는 이벤트에 대응하는 것.
//5. 애플 푸쉬 알림 서브스와 같이 실행시 요구되는 모든 서비스를 등록하는것.
import UIKit			
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
    
    
    // TODO: - UUID를 RestAPI(alamofire 로 데이터 보내기)
    
    let realm = try! Realm()//realm가져오기
    let dataRealm = RealmDBModel()//realm데이터 가져오기
    var allData: AllDataModel!
//    var data: RealmDBModel!

    //데이터 처리 여기서 할것 데이터 먼저 받아오기 db에 저장돼있는 데이터와 uuid 로직 비교
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Override point for customization after application launch.
        
        allData = AllDataModel()
        allData.realm = realm
//        allData.dataRealm = dataRealm struct 참조 xxx
        
        //UUID 생성
        let savedDates = realm.objects(RealmDBModel.self)
        //첫 실행 uuid 저장
        //Todo : - uuid데이터에서 uuid 있는지 검증 없으면 아래로직 있으면 넘기기
        
//        if (savedDates.first?.uuid.isEmpty ?? true) {
//            dataRealm.uuid = UUID().createUuid()
//            dataRealm.email = ""
//            try! realm.write {
//                print("first Add")
//                realm.create(RealmDBModel.self, value: dataRealm.email, update: .modified)
//            }
//         }
        
        //다른경우 로직 구현
        if savedDates.first?.uuid != UUID().createUuid() {
//            savedDates.first?.uuid// 현재의 uuid를 삭제하는 alamofire 보내기 >>>>재현이한테 1차 종료 후 요청
            dataRealm.uuid = UUID().createUuid()
            dataRealm.name = ""
            dataRealm.email = ""
            try! realm.write {
                realm.deleteAll()
                
                realm.create(RealmDBModel.self, value: dataRealm, update: .modified)
            }
        }
        //email이 존재하면
        if (!(savedDates.first?.email.isEmpty ?? false)){
            // input data
            allData.emailInputData(emailOpt: savedDates.first?.email)
        }
        //name이 존재하면
        if (!(savedDates.first?.name.isEmpty ?? false)){
            // input data
            allData.nameInputData(nameOpt: savedDates.first?.name)
        }
        allData.uuidInputData(uuidOpt: savedDates.first?.uuid)
        
        
//불러온데이터 정렬 및 필터
//let realm = try! Realm()
//let savedDates = realm.objects(DateRealm.self)
//// day 기준으로 sorting
//print(savedDates.sorted(byKeyPath: "day", ascending: true))
//// day가 07인 경우만
//print(savedDates.filter("day == '07'"))
//        print(savedDates.filter("uuid == '4A2DAAE6-3D08-438E-A739-B4EF79054287'"))
//        savedDates.filter
//        print(allData.uuid)

            
        
//        dataSelected.uuid = allData.uuidDataUnwrappedGet()
            

            // Updating book with id = 1
//            try! realm.write {
//                realm.add(dataSelected, update: .modified)
//            }
            
            
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        if #available(iOS 13, *) {
            print("set in SceneDelegate")
        } else {
            print("set in AppDelegate")
            
            IOSInfo.statusbar = Int(UIApplication.shared.statusBarFrame.height)
            IOSInfo.screenWidth = Int(UIScreen.main.bounds.width)
            IOSInfo.screenHeight = Int(UIScreen.main.bounds.height)
            
            let emailViewController = EmailViewController()
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            window.rootViewController = emailViewController
            window.rootViewController = UINavigationController(rootViewController: emailViewController)
            window.rootViewController?.navigationController?.isNavigationBarHidden = true
            window.makeKeyAndVisible()
            
            
            //EmailVIewController data share
            emailViewController.allData = self.allData
            
        }
        
        
        
        
        
        return true
    }
    

    
    

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
//        sceneSessions.dele
        
        
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

