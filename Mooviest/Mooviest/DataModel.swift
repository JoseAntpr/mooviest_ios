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
    var path =  "http://192.168.1.129:8000"//"http://localhost:8000"//
    var movies = [Movie]()
    var user:User?
    var authenticationUser: Authentication?
    
    func startActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func login(Username u: String, Password p: String,completionRequest:  @escaping (Bool,String,String?) -> Void){
        let parameters: Parameters = [
            "username": u,
            "password": p
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/login/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []))
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        let msg = res["message"] as? String
                        do {
                            self.authenticationUser = try Authentication(json: res)
                            completionRequest(true, "", msg)
                        } catch {
                            completionRequest(false, "Login error", msg)
                        }
                    }
                    
                case .failure(let error):
                    completionRequest(false, "Connection error", error.localizedDescription)
                }
        }
    }
    
    func register(Username u: String, Password p: String, Email e: String,completionRequest:  @escaping (Bool,String,String?) -> Void){
        let preferredLanguage = NSLocale.preferredLanguages[0] as String
        let codeLang = preferredLanguage.components(separatedBy: "-")[0]
        print(codeLang)
        let parameters: Parameters = [
            "username": u,
            "password": p,
            "email": e,
            "profile": [
                "lang": [
                    "code": codeLang
                ]
            ]
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []))
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        let msg = res["message"] as? String
                        do {
                            self.authenticationUser = try Authentication(json: res)
                            completionRequest(true, "", msg)
                        } catch {
                            completionRequest(false, "Register error", msg)
                        }
                    }
                    
                case .failure(let error):
                    completionRequest(false, "Connection error", error.localizedDescription)
                }
        }
    }
    
    func getUser(completionRequest:  @escaping (Bool,User?)-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/", method: .get, headers: headers)
            .responseJSON {response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    do {
                        self.user = try User(json: res)
                        completionRequest(true, self.user)
                    } catch {
                        self.user = nil
                        completionRequest(false, nil)
                    }
                }
        }
    }
    
    func updateUser(user: User, avatar: UIImage, completionRequest:  @escaping (Bool, String, User?) -> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "multipart/form-data"]
        let url = try! URLRequest(url: "\(path)/api/users/\(user.id)/", method: .put, headers: headers)
        let imageData:Data = UIImageJPEGRepresentation(avatar, 0.2)!
        
        self.startActivity()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(user.username.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "username")
                multipartFormData.append(user.email.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "email")
                multipartFormData.append(user.firstname.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "first_name")
                multipartFormData.append(user.lastname.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "last_name")
                multipartFormData.append(imageData, withName: "profile.avatar", fileName: "\(user.id).jpg", mimeType: "image/jpeg")
                multipartFormData.append(user.gender.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "profile.gender")
                multipartFormData.append(user.born.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "profile.born")
                multipartFormData.append(user.postalCode.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "profile.postalCode")
                multipartFormData.append(user.city.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "profile.city")
                multipartFormData.append(user.codeLang.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "profile.lang.code")
            },
            with: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        self.stopActivity()
                        if let res = response.result.value as? [String:Any] {
                            do {
                                if let status = res["status"] as? Int {
                                    if status == 200 {
                                        self.user = try User(json: res)
                                        completionRequest(true, "", self.user)
                                    } else {
                                        var msg = ""
                                        if let errors = res["errors"] as? [String:Any] {
                                            if let username = errors["username"] as? [String] {
                                                msg += "\n\(username[0])"
                                            }
                                            if let email = errors["email"] as? [String] {
                                                msg += "\n\(email[0])"
                                            }
                                            print(errors)
                                        }
                                        completionRequest(false, msg, nil)
                                    }
                                }
                                
                            } catch {
                                completionRequest(false, "Error parser User", nil)
                            }
                        }
                    }
                case .failure(let msg):
                    completionRequest(false, "Error encoding: \(msg)", nil)
                }
            }
        )
    }
    
    func getMovieList(listname: String, completionRequest:  @escaping ([[String:Any]],String)throws-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/collection/?name=\(listname)", method: .get, headers: headers).responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    var next = ""
                    next.toString(string: res["next"] as Any)
                    try! completionRequest(res["results"] as! [[String:Any]],next)
                }
        }
    }
    
    func getMovie(idmovie: Int, idMovieLang: Int, completionRequest:  @escaping ([String:Any])throws-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/movie/\(idmovie)/?user_id=\(authenticationUser!.idUser)&movie_lang_id=\(idMovieLang)", method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    try! completionRequest(res)
                }
        }
    }

    func searchMovies(name: String, completionRequest:  @escaping ([[String:Any]],String)throws-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let  url = "\(path)/api/movie_lang/?title=\(name)&code=\(authenticationUser!.codeLang)".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        self.startActivity()
        Alamofire.request( url!, method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    var next = ""
                    next.toString(string: res["next"] as Any)
                    try! completionRequest(res["results"] as! [[String:Any]], next)
                }
        }
    }
    
    func nextMovies(url: String, completionRequest:  @escaping ([[String:Any]],String)throws-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( url, method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    
                    var next = ""
                    next.toString(string: res["next"] as Any)
                    try! completionRequest(res["results"] as! [[String:Any]], next)
                }
        }
    }
    
    func insertMovieCollection(idMovie: Int, typeMovie: Int,completionRequest:  @escaping ([String:Any]) -> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "user": authenticationUser!.idUser,
            "movie": idMovie,
            "typeMovie": typeMovie
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/collection/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    
                    completionRequest(res)
                }
        }
    }
    
    func updateMovieCollection(idCollection:Int, typeMovie: Int,completionRequest:  @escaping ([String:Any]) -> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "typeMovie": typeMovie
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/collection/\(idCollection)/", method: .patch,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            self.stopActivity()
            if let res = response.result.value as? [String:Any] {
                
                completionRequest(res)
            }
        }
    }
    
    func getMoviesSwipe(completionRequest:  @escaping ([[String:Any]], String)throws-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]        
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/swipelist/", method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                if let res = response.result.value as? [String:Any] {
                    var next = ""
                    next.toString(string: res["next"] as Any)
                    try! completionRequest(res["results"] as! [[String:Any]], next)
                    
                }
        }
    }
}
