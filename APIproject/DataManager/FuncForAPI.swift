//
//  FuncForAPI.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Alamofire

class FuncForAPI {
    
    private var api: APIHttpProtocol
    
    init(api: APIHttpProtocol = APIhttp()) {
        self.api = api
    }
    
    func getData(complition: @escaping ([Documents]?, _ error: AFError?) -> Void) {
        api.APICall(method: .get, compliteHandler: complition)
    }

    func postData(complition: @escaping ([CreateDoc]?, _ error: AFError?) -> Void) {
        api.APICall(method: .post, compliteHandler: complition)
    }
        
    
        
}
