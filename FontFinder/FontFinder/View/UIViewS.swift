//
//  EmailView.swift
//  FontFiner
//
//  Created by JURA on 2020/02/29.
//  Copyright © 2020 jura. All rights reserved.
//
import UIKit
// MARK: - 설명
// FIXME: - 고칠것
// TODO: - 진행할 사항
//lazy ...  arc  약한참조weak(메모리 누수 관련 optional 들어갈 것같은 경우 사용가능.. ex) delegate...)>> guard let 사용 권장 ...
//



class UIViewS: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func commonInit (_ object: Any) {
        guard let inObjectKey = object as? String else{//guard let 예시
            viewInitLogin()
            self.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
            return
        }

        if inObjectKey == "email" {
            viewInitLogin()
        } else if inObjectKey == "web" {
            viewInitWeb()
        } else if inObjectKey == "setting" {
            viewInitSetting()
        }
    }
    
    func viewInitLogin() {
        nameTextView.delegate = self
        emailTextView.delegate = self
        addSubview(logoImageView)
        addSubview(logoTextImageView)
        
        addSubview(loginStackView)
        addSubview(findFontButton)
        
        setLogoImageView(logoImageView)
        setLogoTextImageView(logoTextImageView)
        
        setEmailStackSubView(loginStackView)
        setEmailStackView(loginStackView)
        setFontFindButton(findFontButton)
        
    }
    func viewInitWeb() {
        addSubview(webViewIn)
        addSubview(topPaddingView)
        
        setWebView(webViewIn)
        setTopPaddingView(topPaddingView)
//        addSubview(toolbarStackView)
//        setToolbarStackSubView(toolbarStackView)
//        setToolbarStackView(toolbarStackView)
        
    }
    func viewInitSetting() {
        addSubview(titleBarLabel)
        addSubview(titleBarLineView)
        addSubview(notificationTitleLabel)
        addSubview(notificationStackView)
        addSubview(preparingTextLabel)
        
        setTitleBarLabel(label: titleBarLabel)
        settitleBarLineView(view: titleBarLineView)
        setNotificationTitleLabel(label: notificationTitleLabel)
        setNotificationStackSubView(stackView: notificationStackView)
        setNotificationStackView(stackView: notificationStackView)
        setPreparingTextLabel(label: preparingTextLabel)
        
        if #available(iOS 13, *) {
            
        } else {
            addSubview(naviButton)
            setNaviButton(button: naviButton)
        }
    }
    
    
    
    
    // MARK: - Login
    // login//////////////////////////////////////////////////////////////////////////////////// //
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "email_logo_black")
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var logoTextImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = #imageLiteral(resourceName: "email_lowerCase")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var loginStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.distribution = .fillEqually //가득 채우겠다
//        stackView.alignment = .fill   //뷰가들어온걸 채우겠다는 의미
        stackView.spacing = 8 //padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        
         let label = UILabel()
         label.text = "Name"
        label.font = UIFont(name: "Impact", size: CGFloat(IOSInfo.screenHeight) * 0.02)
         return label
     }()
     lazy var nameTextView: UITextView = {
         let textView = UITextView()
         textView.isScrollEnabled = false
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 8, left: 4, bottom: 8, right: 4)
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingHead
         textView.text = "Input Name"
        textView.font = UIFont.systemFont(ofSize: CGFloat(IOSInfo.screenHeight) * 0.015)
         textView.textColor = UIColor.black
         return textView
     }()
     lazy var emailLabel: UILabel = {
         let label = UILabel()
         label.text = "E-Mail"

        label.font = UIFont(name: "Impact", size: CGFloat(IOSInfo.screenHeight) * 0.02)

        
         return label
     }()
     lazy var emailTextView: UITextView = {
         let textView = UITextView()
         textView.isScrollEnabled = false
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 8, left: 4, bottom: 8, right: 4)
         textView.text = "Input E-Mail"
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingHead
        textView.font = UIFont.systemFont(ofSize: CGFloat(IOSInfo.screenHeight) * 0.015)
         textView.textColor = UIColor.black
         return textView
     }()
    lazy var findFontButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go Find The Fontl!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Impact", size: CGFloat(IOSInfo.screenHeight) * 0.035)
        button.layer.cornerRadius = CGFloat(IOSInfo.screenHeight) * 0.015
        button.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        button.addTarget(self, action: #selector(didGoButtonClick(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setLogoImageView (_ imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.28),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.13),
        ])
        NSLayoutConstraint(
            item: imageView, attribute: .centerY,
            relatedBy: .equal,
            toItem: self, attribute: .centerY,
            multiplier: 0.5, constant: 0).isActive = true
    }
    func setLogoTextImageView (_ imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: self.logoImageView.widthAnchor, constant: CGFloat(IOSInfo.screenHeight) * 0.05),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
    
    func setEmailStackView(_ stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.logoTextImageView.bottomAnchor, constant: CGFloat(IOSInfo.screenHeight) * 0.09),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }
    func setEmailStackSubView (_ stackView: UIStackView) {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextView)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(emailTextView)
        NSLayoutConstraint.activate([
            stackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            stackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            stackView.arrangedSubviews[2].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            stackView.arrangedSubviews[3].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1)
        ])
    }
    func setFontFindButton (_ button: UIButton) {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: self.loginStackView.bottomAnchor, constant: CGFloat(IOSInfo.screenHeight) * 0.06),
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07)
        ])
    }

        

    
    @objc func didGoButtonClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("didGoButtonClick"), object: nil, userInfo: nil)
    }
    // ///////////////////////////////////////////////////////////////////////////////////email //
    
    
    
    // MARK: - WebView
    // web/////////////////////////////////////////////////////////////////////////////////// //
    lazy var webViewIn:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    lazy var topPaddingView:UIView  = {
        let view = UIView()
        
          view.backgroundColor = #colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
          view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    lazy var toolbarStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.backgroundColor = UIColor.blue
//        stackView.axis = .horizontal
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    func setTopPaddingView(_ uiview:UIView){
        NSLayoutConstraint.activate([
            uiview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            uiview.heightAnchor.constraint(equalToConstant: CGFloat(IOSInfo.statusbar))
            
        ])
    }
    func setWebView(_ uiview:UIView){
        NSLayoutConstraint.activate([
            // TODO: - webViewIn을 topPaddingView로 달아주기
            uiview.topAnchor.constraint(equalTo: self.webViewIn.bottomAnchor, constant: 0),
            uiview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            uiview.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.962)//사이즈를 전체로 주지 않은이유는
                                                                                    //webView의 스크롤바 끝까지 내릴 시 bottom safe area영역이 올라 오는 문제를 해결하기 위해
                                                                                //앞으로영역을 채워야 하는 문제가 생긴다면 view를 추가
        ])
    }
//    func setToolbarStackView(_ stackView: UIStackView){
//       NSLayoutConstraint.activate([
//        stackView.topAnchor.constraint(equalTo: self.webViewIn.bottomAnchor),
//        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
//        stackView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
//       ])
//    }
    
//    func setToolbarStackSubView(_ stackView: UIStackView){
//        var toolbarImageViewArray = [UIImageView]()
//        toolbarImageViewArray.append(.init(image: #imageLiteral(resourceName: "web_toolbar_back")))
//        toolbarImageViewArray.append(.init(image: #imageLiteral(resourceName: "web_toolbar_forward")))
//        toolbarImageViewArray.append(.init(image: #imageLiteral(resourceName: "web_toolbar_home")))
//        toolbarImageViewArray.append(.init(image: #imageLiteral(resourceName: "web_toolbar_refresh")))
//        toolbarImageViewArray.append(.init(image: #imageLiteral(resourceName: "web_toolbar_setting")))
//        for item in toolbarImageViewArray {
//            stackView.addArrangedSubview(item)
//        }
//        NSLayoutConstraint.activate([
//            stackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
//            stackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
//            stackView.arrangedSubviews[2].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
//            stackView.arrangedSubviews[3].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
//            stackView.arrangedSubviews[4].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2)
//        ])
//    }
    // ///////////////////////////////////////////////////////////////////////////////////web //
    
    
    
    // MARK: - Setting
    // setting/////////////////////////////////////////////////////////////////////////////////// //
    

    
    lazy var titleBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansCJKkr-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var naviButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "setting_button_down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didBackButtonClick(_:)), for: .touchUpInside)
        return button
    }()
    lazy var titleBarLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var notificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var notificationSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Receive Notification"
        return label
    }()
    lazy var notificationSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        return uiSwitch
    }()
    lazy var notificationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering //가득 채우겠다
        stackView.alignment = .fill   //뷰가들어온걸 채우겠다는 의미
        //        stackView.spacing = 8 //padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var preparingTextLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 2
        label.text = "we are currently preparing. \nplease, wait for service."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setTitleBarLabel(label: UILabel) {
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
            //TODO: - label.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func setNaviButton(button: UIButton) {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07),
            button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            button.centerYAnchor.constraint(equalTo: titleBarLabel.centerYAnchor)
        ])
        NSLayoutConstraint(
        item: button, attribute: .centerX,
        relatedBy: .equal,
        toItem: self, attribute: .centerX,
        multiplier: 0.15, constant: 0).isActive = true
    }
    func settitleBarLineView(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.titleBarLabel.bottomAnchor),
            view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.002)
        ])
    }
    func setNotificationTitleLabel(label: UILabel) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: titleBarLabel.bottomAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
        ])
    }
    func setNotificationStackSubView(stackView: UIStackView) {
        stackView.addArrangedSubview(self.notificationSubTitleLabel)
        stackView.addArrangedSubview(self.notificationSwitch)
    }
    func setNotificationStackView(stackView: UIStackView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: notificationTitleLabel.bottomAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)
            
        ])
    }
    func setPreparingTextLabel(label: UILabel) {
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func didBackButtonClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("didBackButtonClick"), object: nil, userInfo: nil)
    }
    
}

// ///////////////////////////////////////////////////////////////////////////////////web //





extension UIViewS: UITextViewDelegate {
    //hint(입력 받을떄)
     public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.black
        }
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if(textView.isEqual(nameTextView)) {
                textView.text = "Input Name(Only English)"
            }else if(textView.isEqual(emailTextView)) {
               textView.text = "Input E-Mail(Only English)"
                
                
                

                
            }
            textView.textColor = UIColor.lightGray
        }
        //        if strUrlScheme?.hasPrefix(UrlInfo.schemeName) == true {
        //        strUrlScheme = strUrlScheme?.replacingOccurrences(of: UrlInfo.schemeName, with: "")
        
        
        //'@'가 있어야하고,  '.' 있어야한다.....
        //@ 가 .인덱스보다 커야한다
        //@ 나 . 이 2개이상
        //@ 나 . 외의 코드가 들어오면 안된다
//        if (textView.text.contains("@") && textView.text.contains(".")){
//            
//            let firstText = ""
//            let secondText = ""
//            let thirdText = ""
//            let splitArrFirst = textView.text.split(separator: "@")
//            splitArrFirst[0]
//            
//         print("ooo")
//        }else {
//         print("ttt")
//        }
        

        //@랑 . 사이에 문자야있어야하고
            //.뒤에 문자가 있어야한다.
        //@앞에 문자가 이써양한다.
        //@가있는 문자index 번호를 검출
        //.이있는 문자index 번호를 검출
        
//        textView.hex
        
    }
//    func textViewDidChange(_ textView: UITextView) {
//        // TODO: - 엔터키가 들어왔을때 리턴시키거나 다음 줄커서로 변경할 수있게 조정
////         var inText = textView.text.append("\n") 추가
//        var inText = textView.text.
//
//        print(inText)
//        if textView.isEqual(nameTextView) {
////            if(textView.text == "\n") ()
//        } else if textView.isEqual(emailTextView) {
////            print()
//        }
//    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //붙여넣기 또는 백스페이스 방지 체크 영문만 가능하게 로직 변경
        if text.count > 1 {
            return false
        }
        if text != "" {
            if !text.isEmpty {
                guard let textASCIIcheck = Character(text).asciiValue else {
                    return false
                }
            }
        }
        

        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
 

