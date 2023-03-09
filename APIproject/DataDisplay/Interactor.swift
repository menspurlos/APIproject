//
//  Interactor.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Foundation
import Alamofire


protocol InteractorInputProtocol {
    init(presenter: InteractorOutputProtocol)
    func getDataFromAPI()
    func createDoc()
}

protocol InteractorOutputProtocol: AnyObject {
    func reciveData(data: [Documents])
    func documentWasCreated(with number: String)
    func reportABug(error: AFError)
    
}

class Interactor: InteractorInputProtocol {

    let funcForAPI = FuncForAPI()

    unowned let presenter: InteractorOutputProtocol
    
    required init(presenter: InteractorOutputProtocol) {
        self.presenter = presenter
    }
   
    func getDataFromAPI(){
        
        funcForAPI.GetData {[weak self] dataAPI, error in
                guard let self = self else { return }
                if let dataAPI = dataAPI {
                    let docs = dataAPI
                    self.presenter.reciveData(data: docs)
                }
                if error != nil {
                    self.presenter.reportABug(error: error!)
                    }
        }
    }
    
    func createDoc() {
        funcForAPI.PostData {[weak self] dataAPI, error in
            guard let self = self else { return }
            if let dataAPI = dataAPI {
                let numberdoc = dataAPI.first!.number
                self.presenter.documentWasCreated(with: numberdoc)
            }
            if error != nil {
                self.presenter.reportABug(error: error!)
            }
        }
    }
    
    
    
    
    
    
}
