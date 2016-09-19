//
//  DataModel.swift
//  Mooviest
//
//  Created by Antonio RG on 26/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Alamofire


class DataModel: NSObject {
    static let sharedInstance = DataModel()
    var path =  "http://192.168.1.136:8000/api"//"http://localhost:8000/api"// 
    var movies = [Movie]()
    
    
    func getMoviesSwipe(Lang l: Int, Count c: Int,completionRequest:  @escaping ([[String:Any]]) -> Void){
        let user = "admin"
        let password = "admin"
        
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let headers = ["Authorization": "Basic \(base64Credentials)","Content-Type": "application/json"]
        
        
        Alamofire.request( "\(path)/movie_app_bylang?lang_id=\(l)&limit=\(c)", method: .get, headers: headers)
            .responseJSON {response in
                if let res = response.result.value as? [String:Any] {
                    completionRequest(res["results"] as! [[String:Any]])
                }
        }
    }
    
    func login(Username u: String, Password p: String,completionRequest:  @escaping ([String:Any]) -> Void){
        let user = "admin"
        let password = "admin"
        
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let headers = ["Authorization": "Basic \(base64Credentials)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "username": u,
            "password": p
        ]
        
        Alamofire.request( "\(path)/users/login/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers)
            .responseJSON {response in
                if let res = response.result.value as? [String:Any] {
                    completionRequest(res)
                }
        }
    }
    
    func register(Username u: String, Password p: String, Email e: String, Lang l: String,completionRequest:  @escaping ([String:Any]) -> Void){
        let user = "admin"
        let password = "admin"
        
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        
        let headers = ["Authorization": "Basic \(base64Credentials)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "username": u,
            "password": p,
            "email": e,
            "profile": [
                "lang": [
                    "code": l
                ]
            ]
        ]
        
        Alamofire.request( "\(path)/users/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers)
            .responseJSON {response in
                
                if let res = response.result.value as? [String:Any] {
                    completionRequest(res)
                }
        }
    }
}

//    var map = [Territory]()
//    var coordMap = [[String:AnyObject]]()
//    var TerritoryPos = [String:Int]()




//
//    func initGame(paramsGame p: [String: AnyObject], completionInit endInit: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.POST, "\(path)/init", parameters: p, encoding: .JSON)
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endInit(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func sendAction(paramsAction p: [String: AnyObject], completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.POST, "\(path)/action", parameters: p, encoding: .JSON)
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func sendResolve(paramsResolve p: [String: AnyObject], completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.POST, "\(path)/resolve", parameters: p, encoding: .JSON)
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func sendRetreat(paramsRetreat p: [String: AnyObject], completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.POST, "\(path)/retreat", parameters: p, encoding: .JSON)
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func sendReadjustment(paramsReadjustment p: [String: AnyObject], completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.POST, "\(path)/readjustment", parameters: p, encoding: .JSON)
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func finishNegotation(paramsRetreat p: AnyObject, completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.GET, "\(path)/finishNegotiation/\(p)")
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func findGameById(match m: String, completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.GET, "\(path)/getgame/\(m)")
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//
//                    //print("JSON: \(jsonString)")
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }
//
//    func getAllGame(completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//
//        Alamofire.request(.GET, "\(path)/games")
//            .responseJSON { response in
//                if let jsonString = response.result.value {
//                    let res:[String:AnyObject] = [
//                        "games": jsonString
//                    ]
//                    //print("JSON: \(jsonString)")
//                    endSend(data: res )
//                }
//
//        }
//    }
//
//    func insertGame(paramsRetreat p: AnyObject, completionSend endSend: (data:[String:AnyObject]) -> Void) {
//
//        Alamofire.request(.GET, "\(path)/game/findById/\(p)")
//            .responseJSON { response in
//
//                if let jsonString = response.result.value {
//                    endSend(data: jsonString as! [String : AnyObject])
//                }
//
//        }
//    }



