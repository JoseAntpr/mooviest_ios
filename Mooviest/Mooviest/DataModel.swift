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
    var path =  "http://192.168.1.33:8000/api"//"http://localhost:8000/api"//
    var movies = [Movie]()
    var user:User!
    
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
