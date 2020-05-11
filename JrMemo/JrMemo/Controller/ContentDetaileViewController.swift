//
//  ContentDetaileViewController.swift
//  JrMemo
//
//  Created by JURA on 2019. 1. 16..
//  Copyright © 2019년 jura. All rights reserved.
//

import UIKit

class ContentDetaileViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: @IBOutlet
    @IBOutlet var inputSubjectTextField: UITextField!
    @IBOutlet var contentDetaileTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: property
    var tempContentText: String!
    var imageStore: ImageStore!
    var subjectItem: SubjectItem!{
        didSet {
            tempContentText = subjectItem.contentDetail
            if tempContentText == "tempContentText" {
                tempContentText = ""
            }
        }
    }
    
    
    // MARK: init()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fin", style: UIBarButtonItem.Style.plain, target: self, action: #selector(touchDownFin(_:)))
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let camera = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(addContentImage(_:)))
        setToolbarItems([flexibleSpace, camera], animated: true)
        
        contentDetaileTextView.delegate = self
        if contentDetaileTextView.text.isEmpty {
            contentDetaileTextView.textColor = UIColor.lightGray
            contentDetaileTextView.text = "Text input"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  subjectItem.subjectTitle != "Not Subject" {
            inputSubjectTextField.text = subjectItem.subjectTitle
        }
        if !(subjectItem.contentDetail?.isEmpty)! {
            contentDetaileTextView.text = subjectItem.contentDetail
            contentDetaileTextView.textColor = UIColor.black
            if contentDetaileTextView.text == "Text input" {
                contentDetaileTextView.textColor = UIColor.lightGray
            }
        } else if (subjectItem.contentDetail?.isEmpty)! || contentDetaileTextView.text == "Text input" {
            contentDetaileTextView.textColor = UIColor.lightGray
        }
            let  key = subjectItem.imageKey
            let imageToDisPlay = imageStore.imageForKey(key: key)
            imageView.image = imageToDisPlay
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !(inputSubjectTextField.text?.isEmpty)! {
            subjectItem.subjectTitle = inputSubjectTextField.text
        } else {
            subjectItem.subjectTitle = "Not Subject"
        }
        print(subjectItem.isEmptyImage)
    }
    
    
    // MARK: textView DataSource
    func textViewDidBeginEditing(_ textView: UITextView) {
        //에디트 모드 돌입 시 텍스트 색상이 lightGray 일 경우 색상을 검정으로 바꾸
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Text input"
            textView.textColor = UIColor.lightGray
        }
        if !(inputSubjectTextField.text?.isEmpty)! {
            subjectItem.subjectTitle = inputSubjectTextField.text
        } else {
            subjectItem.subjectTitle = "Not Subject"
        }
        subjectItem.contentDetail = contentDetaileTextView.text
        //처음 값 과 수정 값이 다를경우 날짜 변경
        if tempContentText != subjectItem.contentDetail {
            subjectItem.subjectDate = subjectItem.dateFormatter.string(from: Date())
        }
    }
    
    
    // MARK: @objc
    @objc func touchDownFin(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    @objc func addContentImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
     @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageStore.setImage(image: image, forKey: subjectItem.imageKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
        subjectItem.isEmptyImage = false
    }
}
