//
//  FuncForAPI.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Alamofire

class FuncForAPI {
    
    var api: APIHttpProtocol
    
    init(api: APIHttpProtocol = APIhttp()) {
        self.api = api
    }
    
    static let funcForAPI = FuncForAPI()
    
    func GetData(complition: @escaping ([Documents]?, _ error: AFError?) -> Void) {
        api.APICall(method: .get, compliteHandler: complition)
    }

    func PostData(complition: @escaping ([CreateDoc]?, _ error: AFError?) -> Void) {
        api.APICall(method: .post, compliteHandler: complition)
    }
        
    
        
}
