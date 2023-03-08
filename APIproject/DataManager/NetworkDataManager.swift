//
//  NetworkDataManager.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Foundation
import Alamofire

protocol APIHttpProtocol {
    func APICall<T: Decodable>(method: HTTPMethod, compliteHandler: @escaping (_ dataAPI:[T]?, _ error: AFError?) -> Void)
}

class APIhttp: APIHttpProtocol {
    
    
    //static let sharedAPI = APIhttp()
    
    let url = "http://5.130.157.177/CBBudzhet/hs/http"
    
    func APICall<T: Decodable>(method: HTTPMethod, compliteHandler: @escaping (_ dataAPI:[T]?, _ error: AFError?) -> Void) {
        AF.request(url,
                   method: method,
                   parameters: nil,
                   encoding: URLEncoding.default ,
                   headers: nil,
                   interceptor: nil
        ).validate().response { responce in

            switch responce.result {
            case .success(let data):
                do {
                    let dataAPI = try JSONDecoder().decode([T].self, from: data!)
                    compliteHandler(dataAPI, nil)
                } catch {
                    let error = error as! AFError
                    compliteHandler(nil, error)
                }
            case .failure(let error):
                compliteHandler(nil, error)
            }
        }
    }
    
}
