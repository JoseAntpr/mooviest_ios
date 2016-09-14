//
//  DataModel.swift
//  Mooviest
//
//  Created by Antonio RG on 26/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DataModel: NSObject {
    static let sharedInstance = DataModel()
    var path =  "http://localhost:8000/api"// "http://192.168.1.134:8000/api"//
    var movies = [Movie]()

    
    func getMoviesSwipe(Lang l: Int, Count c: Int,completionRequest endRequest: (data:[JSON]) -> Void) {
        let user = "admin"
        let password = "admin"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)","Content-Type": "application/json"]
        
        
        Alamofire.request(.GET, "\(path)/movie_app_bylang?lang_id=\(l)&limit=\(c)", headers: headers)
            .responseJSON {response in
                if let jsonString = response.result.value {
                    let movies = JSON(jsonString as! [String : AnyObject])["results"].array!
                    endRequest(data: movies)
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
    
    

