//
//  SQLConnect.swift
//  TagPicture
//
//  Created by JURA on 2019. 6. 15..
//  Copyright © 2019년 jura. All rights reserved.
//

import Foundation

class SQLConnect {
    let URL_TAGPICTURE = "http://hegs3.ipdisk.co.kr:8080/TagPicturePhp/API/"
    
    var tagStore: TagStore!
    
    let uuid: String
    var cntDate: String
    var now: Date = Date()
    var lastAuth:Int
    
    
    var dictionaryToArrayS: [String]!
    var dictionaryToArrayA: [Int]!
    var dictionaryToArrayL: [Int]!
    
    var dictionaryToArrayPicid: [String]!
    var dictionaryToArrayTitle: [String]!
    var dictionaryToArrayUpdateD: [Date]!
    var dictionaryToArrayURL: [URL]!
    var dictionaryToArrayPhotoSize: [String]!
    var dictionaryToArrayAuthP: [Int]!
    
    var myJSON: [Dictionary<String, Any >]?
    var myJSON2: [Dictionary<String, Any>]?
    
    
    
    init() {
        let uuid = UUID()
        self.uuid = uuid.createUUID()
        now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cntDate = date.string(from: now)
        dictionaryToArrayS = []
        dictionaryToArrayA = []
        dictionaryToArrayL = []
        dictionaryToArrayPicid = []
        dictionaryToArrayTitle = []
        dictionaryToArrayUpdateD = []
        dictionaryToArrayURL = []
        dictionaryToArrayPhotoSize = []
        dictionaryToArrayAuthP = []
        lastAuth = 1
    }

    
    //TODO : 여기서 데이터 처리하는 로직 구현
    func verification() {
        let URL_verification = URL_TAGPICTURE + "verification.php"
        let requestURL = URL(string: URL_verification)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&cntDate="+cntDate
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        

        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    self.myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Dictionary<String, Any>]
                    if let parseJSON = self.myJSON{
                        var msg = parseJSON
                        var translateSubject: String
                        var translateAuth: Int
                        var translateLine: Int
                        
                        var translatePicid: String
                        var translateTitle: String
                        var translateUpdateD: String
                        var translateURL: String
                        var translatePhotoSize: String
                        var translateAuthP: Int
                        
                        
                        var j = 0
                        for _ in msg {
                            if msg[j]["subject"] == nil {
                                translatePicid = (msg[j]["picid"]! as! String)
                                translateTitle = (msg[j]["title"]! as! String)
                                translateUpdateD = (msg[j]["updateD"]! as! String)
                                translateURL = (msg[j]["URL"]! as! String)
                                translatePhotoSize = (msg[j]["photosize"]! as! String)
                                translateAuthP = (msg[j]["auth"]! as! Int)
                                
                                let url = URL(string: translateURL)
                                let dateFormatter = DateFormatter()
                                dateFormatter.locale = Locale(identifier: "ko_kr")
                                dateFormatter.timeZone = TimeZone(abbreviation: "KST") // "2018-03-21 18:07:27"
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date = dateFormatter.date(from: translateUpdateD)

                                self.dictionaryToArrayPicid.append(translatePicid)
                                self.dictionaryToArrayTitle.append(translateTitle)
                                self.dictionaryToArrayUpdateD.append(date!)
                                self.dictionaryToArrayURL.append(url!)
                                self.dictionaryToArrayPhotoSize.append(translatePhotoSize)
                                self.dictionaryToArrayAuthP.append(translateAuthP)
                            } else {
                                translateSubject = (msg[j]["subject"]! as! String)
                                translateAuth = (msg[j]["auth"]! as! Int)
                                translateLine = (msg[j]["line"]! as! Int)
                                self.dictionaryToArrayS.append(translateSubject)
                                self.dictionaryToArrayA.append(translateAuth)
                                self.dictionaryToArrayL.append(translateLine)
                            }
                            j += 1
                        }
                        if self.dictionaryToArrayS.count == 0 {
                            return
                        }
                    }
                    let trainS = self.dictionaryToArrayS!
                    let trainA = self.dictionaryToArrayA!
                    let trainL = self.dictionaryToArrayL!
                    
                    
                    
                    var i = 0
                    for _ in trainL {
                        self.tagStore.tagAll.append(Tag.init(line: trainL[i], subject: trainS[i], auth: trainA[i]))
                        i += 1
                    }
                    
                   
                    
                    
                    let trainPickid = self.dictionaryToArrayPicid!
                    let trainTitle = self.dictionaryToArrayTitle!
                    let trainUpdateD = self.dictionaryToArrayUpdateD!
                    let trainURL = self.dictionaryToArrayURL!
                    let trainPhotoSize = self.dictionaryToArrayPhotoSize!
                    let trainAuthP = self.dictionaryToArrayAuthP!
                    
                    if trainAuthP.isEmpty {
                        return
                    }
                    var a = 0 //밖 for문에서 사용(auth계산)
                    for authValue in trainAuthP {
                        for value in self.tagStore.tagAll {
                            if value.auth == authValue {
                                value.photoAll.append(Photo(title: trainTitle[a], photoID:trainPickid[a], remoteURL: trainURL[a], cntDate: trainUpdateD[a], width: 0, height: 0, photoSize: trainPhotoSize[a], auth: trainAuthP[a]))
                            }
                        }
                        a += 1
                    }
                    
                } catch {
                    print(error)
                }
            })
            task.resume()
        }

    }
    
    func createTag(line: Int, subject: String) {
        let URL_createTag = URL_TAGPICTURE + "createTag.php"
        let requestURL = URL(string: URL_createTag)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&line="+"\(line)"+"&subject="+subject
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
	                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    self.myJSON2 = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Dictionary<String, Any>]
                    if let parseJSON = self.myJSON2{
                        var msg = parseJSON
                        self.lastAuth = (msg[0]["AUTO_INCREMENT"]! as! Int) - 1
                        let item = self.tagStore.tagAll.last
                        item?.auth = self.lastAuth
                        
                        
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    
    func editTag(auth: Int, subject: String) {
        let URL_editTag = URL_TAGPICTURE + "editTag.php"
        let requestURL = URL(string: URL_editTag)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&auth="+"\(auth)"+"&subject="+"\(subject)"

        
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
            
            if error != nil {
                print("error is \(String(describing: error))")
                return
            }
            do {
                //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                if let parseJSON = myJSON{
                    var msg: String!
                    msg = parseJSON["message"] as! String?
                    print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                    print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                    print("2\(parseJSON)") //전체 출력
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    func moveTag() {
        let tagAll = tagStore.tagAll
        
        var index = 0
        var lineArray = [Int]()
        var authArray = [Int]()
        for _ in tagAll {
            lineArray.append(tagAll[index].line)
            authArray.append(tagAll[index].auth)
            
            index += 1
        }
        print(lineArray)
        print(authArray)
        
        
        let URL_moveTag = URL_TAGPICTURE + "moveTag.php"
        let requestURL = URL(string: URL_moveTag)
        let request = NSMutableURLRequest(url: requestURL!)

        let postParameters = "uuid="+uuid+"&lineArray="+"\(lineArray)"+"&authArray="+"\(authArray)"
        
        
        
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태

            if error != nil {
                print("error is \(String(describing: error))")
                return
            }
            do {
                //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                if let parseJSON = myJSON{
                    var msg: String!
                    msg = parseJSON["message"] as! String?
//                    print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
//                    print("1\(msg!)")//json에서 message에 해당하는 결과 출력
//                    print("2\(parseJSON)") //전체 출력
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    func pickPhoto(selectedAuth: Int, selectedPhoto: Photo){
        let URL_pickPhoto = URL_TAGPICTURE + "pickPhoto.php"
        let requestURL = URL(string: URL_pickPhoto)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&auth="+"\(selectedAuth)"+"&picid="+"\(selectedPhoto.photoID)"+"&title="+"\(selectedPhoto.title)"+"&updateD="+"\(selectedPhoto.dateTaken)"+"&URL="+"\(selectedPhoto.remoteURL)"+"&photosize="+"\(selectedPhoto.photoSize)"
        print(postParameters)
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                    if let parseJSON = myJSON{
                        var msg: String!
                        msg = parseJSON["message"] as! String?
                        print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                        print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                        print("2\(parseJSON)") //전체 출력
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    
    func removeTag(auth: Int) {
        let URL_removeTag = URL_TAGPICTURE + "removeTag.php"
        let requestURL = URL(string: URL_removeTag)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&auth="+"\(auth)"
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
            
            if error != nil {
                print("error is \(String(describing: error))")
                return
            }
            do {
                //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                if let parseJSON = myJSON{
                    var msg: String!
                    msg = parseJSON["message"] as! String?
                    print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                    print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                    print("2\(parseJSON)") //전체 출력
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    func removeTagAll() {
        let URL_removeTag = URL_TAGPICTURE + "removeTagAll.php"
        let requestURL = URL(string: URL_removeTag)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                    if let parseJSON = myJSON{
                        var msg: String!
                        msg = parseJSON["message"] as! String?
                        print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                        print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                        print("2\(parseJSON)") //전체 출력
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    
    func removePhotoAll(selectedAuth: Int){
        
        let URL_pickPhoto = URL_TAGPICTURE + "removePhotoAll.php"
        let requestURL = URL(string: URL_pickPhoto)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&auth="+"\(selectedAuth)"
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                    if let parseJSON = myJSON{
                        var msg: String!
                        msg = parseJSON["message"] as! String?
                        print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                        print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                        print("2\(parseJSON)") //전체 출력
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    func removePhoto(selectedPhotoId: String){
        
        let URL_pickPhoto = URL_TAGPICTURE + "removePhoto.php"
        let requestURL = URL(string: URL_pickPhoto)
        let request = NSMutableURLRequest(url: requestURL!)
        let postParameters = "uuid="+uuid+"&picid="+"\(selectedPhotoId)"
        print(selectedPhotoId)
        request.httpMethod = "POST"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let mainQueue = DispatchQueue(label: "mainQ")
        mainQueue.sync {
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data, responsw, error) -> Void in// data는 웹 응답값 >> JSON 형태
                
                if error != nil {
                    print("error is \(String(describing: error))")
                    return
                }
                do {
                    //웹에서 json으로 반환되는 출력된 값을 파싱하기위해 JSON사용
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                    if let parseJSON = myJSON{
                        var msg: String!
                        msg = parseJSON["message"] as! String?
                        print(parseJSON["error"]!)//json에서 error에 해당하는 결과 출력
                        print("1\(msg!)")//json에서 message에 해당하는 결과 출력
                        print("2\(parseJSON)") //전체 출력
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    
    
}
