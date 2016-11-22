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
    var path = "http://192.168.1.133:8000" //"http://127.0.0.1:8000"//
    var movies = [Movie]()
    var user:User?
    var authenticationUser: Authentication?
    let userDefault = UserDefaults()
    let connectionMsg = NSLocalizedString("connectionMsg", comment: "Title of connection DataModel")
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
                            self.saveContext()
                        } catch {
                            let title = NSLocalizedString("loginTitle", comment: "Title of login")
                            completionRequest(false, title, msg)
                        }
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription)
                }
        }
    }
    
    func register(Username u: String, Password p: String, Email e: String,completionRequest:  @escaping (Bool,String,String?) -> Void){
        let preferredLanguage = NSLocale.preferredLanguages[0] as String
        var codeLang = preferredLanguage.components(separatedBy: "-")[0]
        if codeLang != "es" && codeLang != "en" {
            codeLang = "en"
        }
        
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
                            let title = NSLocalizedString("registerTitle", comment: "Title of register")
                            completionRequest(false, title, msg)
                        }
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription)
                }
        }
    }
    
    func getUser(completionRequest:  @escaping (Bool,String,String?)-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/", method: .get, headers: headers)
            .responseJSON {response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        do {
                            self.user = try User(json: res)
                            completionRequest(true, "","")
                        } catch {
                            let title = NSLocalizedString("getUserTitle", comment: "Title of getUser")
                            let msg = NSLocalizedString("getUserMsg", comment: "Message of getUser")
                            completionRequest(false, title,msg)
                        }
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription)
                }
        }
    }
    
    func updateLang(completionRequest:  @escaping (Bool,String,String?) -> Void){
        let preferredLanguage = NSLocale.preferredLanguages[0] as String
        var codeLang = preferredLanguage.components(separatedBy: "-")[0]
        if codeLang != "es" && codeLang != "en" {
            codeLang = "en"
        }
        if authenticationUser?.codeLang != codeLang {
            let parameters: Parameters = [
                "lang_code": codeLang
            ]
            let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
            self.startActivity()
            Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/lang/", method: .post,parameters: parameters, encoding: JSONEncoding(options: []), headers: headers)
                .responseJSON { response in
                    self.stopActivity()
                    switch response.result {
                    case .success:
                        if let res = response.result.value as? [String:Any] {
                            let msg = res["message"] as? String
                            do {
                                self.authenticationUser = try Authentication(json: res)
                                completionRequest(true, "", msg)
                                self.saveContext()
                            } catch {
                                let title = NSLocalizedString("loginTitle", comment: "Title of login")
                                completionRequest(false, title, msg)
                            }
                        }                        
                    case .failure(let error):
                        completionRequest(false, self.connectionMsg, error.localizedDescription)
                    }
            }
        }
    }
    
    func updateUser(user: User, avatar: UIImage, completionRequest:  @escaping (Bool,String,String?) -> Void){
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
            with: url, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        self.stopActivity()
                        let titleError = NSLocalizedString("getUserTitle", comment: "Title of updateUser")
                        switch response.result {
                        case .success:
                            do {
                                if let res = response.result.value as? [String:Any] {
                                    if let status = res["status"] as? Int {
                                        if status == 200 {
                                            self.user = try User(json: res)
                                            let msg = NSLocalizedString("updateUserSMsg", comment: "Message of updateUser")
                                            completionRequest(true, "", msg)
                                        } else {
                                            var msg = ""
                                            if let errors = res["errors"] as? [String:Any] {
                                                if let username = errors["username"] as? [String] {
                                                    msg += "\n\(username[0])"
                                                }
                                                if let email = errors["email"] as? [String] {
                                                    msg += "\n\(email[0])"
                                                }
                                            }
                                            completionRequest(false, titleError, msg)
                                        }
                                    }
                                }
                                
                            } catch {
                                
                                let msg = NSLocalizedString("updateUserRMsg", comment: "Message of updateUser")
                                completionRequest(false, titleError,msg)
                            }
                        case .failure(let error):
                            completionRequest(false, self.connectionMsg, error.localizedDescription)
                        }
                    }
                case .failure(let msg):
                    self.stopActivity()
                    let title = NSLocalizedString("updateUserTitle", comment: "Title of updateUser")
                    completionRequest(false, title, "\(msg)")
                }
            }
        )
    }
    
    func getMovieList(listname: String, completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/collection/?name=\(listname)", method: .get, headers: headers).responseJSON { response in
            self.stopActivity()
            switch response.result {
            case .success:
                if let res = response.result.value as? [String:Any] {
                    completionRequest(true, "","", res)
                }
                
            case .failure(let error):
                completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
            }
        }
    }

    func searchMovies(name: String, completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let  url = "\(path)/api/movie_lang/?title=\(name)&code=\(authenticationUser!.codeLang)".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        self.startActivity()
        Alamofire.request( url!, method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        completionRequest(true, "","", res)
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
                }
        }
    }
    
    func searchMoviesByCelebrity(celebrity_id: Int, completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let  url = "\(path)/api/movie_lang/participation/?celebrity=\(celebrity_id)&code=\(authenticationUser!.codeLang)".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        self.startActivity()
        Alamofire.request( url!, method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        completionRequest(true, "","", res)
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
                }
        }
    }
    
    func nextMovies(url: String, completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( url, method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        completionRequest(true, "","", res)
                    }
                    
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
                }
        }
    }
    
    func getMovie(idmovie: Int, idMovieLang: Int, completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        self.startActivity()
        Alamofire.request( "\(path)/api/movie/\(idmovie)/?user_id=\(authenticationUser!.idUser)&movie_lang_id=\(idMovieLang)", method: .get, headers: headers)
            .responseJSON { response in
                self.stopActivity()
                switch response.result {
                case .success:
                    if let res = response.result.value as? [String:Any] {
                        completionRequest(true, "","", res)
                    }
                case .failure(let error):
                    completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
                }
        }
    }
    
    func insertMovieCollection(idMovie: Int, typeMovie: Int,completionRequest:  @escaping (Bool,String,String?,[String:Any]) -> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "user": authenticationUser!.idUser,
            "movie": idMovie,
            "typeMovie": typeMovie
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/collection/", method: .post,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            self.stopActivity()
            switch response.result {
            case .success:
                if let res = response.result.value as? [String:Any] {
                    completionRequest(true, "","", res)
                }
            case .failure(let error):
                completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
            }
        }
    }
    
    func updateMovieCollection(idCollection:Int, typeMovie: Int,completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]
        let parameters: Parameters = [
            "typeMovie": typeMovie
        ]
        self.startActivity()
        Alamofire.request( "\(path)/api/collection/\(idCollection)/", method: .patch,parameters: parameters,encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            self.stopActivity()
            switch response.result {
            case .success:
                if let res = response.result.value as? [String:Any] {
                    completionRequest(true, "","", res)
                }
            case .failure(let error):
                completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
            }
        }
    }
    
    func getMoviesSwipe(completionRequest:  @escaping (Bool,String,String?,[String:Any])-> Void){
        let headers = ["Authorization": "Token \(authenticationUser!.token)","Content-Type": "application/json"]        
        self.startActivity()
        Alamofire.request( "\(path)/api/users/\(authenticationUser!.idUser)/swipelist/", method: .get, headers: headers)
            .responseJSON { response in
            self.stopActivity()
            switch response.result {
            case .success:
                if let res = response.result.value as? [String:Any] {
                    completionRequest(true, "","", res)
                }
                
            case .failure(let error):
                completionRequest(false, self.connectionMsg, error.localizedDescription, [String:Any]())
            }
        }
    }
    
    func errorConnetion(title:String) {        
        if title == connectionMsg {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginViewController()
        }
    }
    
    func saveContext() {
        let token = (authenticationUser?.token)! as String
        userDefault.set(token, forKey: "token")
        userDefault.synchronize()
        let idUser = (authenticationUser?.idUser)! as Int
        userDefault.set(idUser, forKey: "idUser")
        userDefault.synchronize()
        let codeLang = (authenticationUser?.codeLang)! as String
        userDefault.set(codeLang, forKey: "codeLang")
        userDefault.synchronize()
    }

    func loadContext()-> Bool {
        if let token = userDefault.object(forKey: "token") as? String,
            let idUser = userDefault.object(forKey: "idUser") as? Int,
            let codeLang = userDefault.object(forKey: "codeLang") as? String {
            authenticationUser = Authentication(idUser: idUser, token: token, codeLang: codeLang)
        }
        return authenticationUser != nil
    }
    
    func resetDataUser () {
        authenticationUser = nil
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
