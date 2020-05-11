//
//  ViewController.swift
//  FontFInder
//
//  Created by JURA on 2020/02/27.
//  Copyright © 2020 jura. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class EmailViewController: UIViewController {
    
    var uiViews: UIViewS!
    var allData: AllDataModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViews = UIViewS(frame: self.view.frame)
        uiViews.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        uiViews.commonInit("email")//여차하면 view appear로 옮기기 왜냐면 로그아웃때도 생각해야하기때문에
        view.addSubview(uiViews)
        
        
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRecieveNotification(_:)),
                                               name: NSNotification.Name("didGoButtonClick"),
                                               object: nil)
        
        uiViews.nameTextView.text = allData.nameDataUnwrappedGet()
        uiViews.emailTextView.text = allData.emailDataUnwrappedGet()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    
    
    
    
    
    
    @objc func didRecieveNotification(_ notification: Notification) {
//        allData.uuid
        
        let webViewController = WebViewController()
        
        self.navigationController?.pushViewController(webViewController, animated: true)
//        
        allData.emailInputData(emailOpt: uiViews.emailTextView.text)
        allData.nameInputData(nameOpt: uiViews.nameTextView.text)

        webViewController.allData = self.allData
        webViewController.emailUiViews = self.uiViews
        
        restAPIsendEmail()
    }
    func restAPIsendEmail() {
            let parameters: [String: String] = [
                "name": allData.nameDataUnwrappedGet(),
                "email": allData.emailDataUnwrappedGet(),
                "uuid": allData.uuidDataUnwrappedGet()
            ]
            print(allData.nameDataUnwrappedGet())
            print(allData.emailDataUnwrappedGet())
            print(allData.uuidDataUnwrappedGet())
            AF.request("http://hegs3.ipdisk.co.kr:8080/Font/index.php",
                       method: .post,
                       parameters: parameters,
                       encoder: URLEncodedFormParameterEncoder.default
            ).responseJSON {
                        response in
    //            debugPrint(response)
                
                switch response.result {
                case .success:
                    print("Validation Successful")
                case let .failure(error):
                    print(error)
                }
            }
        }
    
}

