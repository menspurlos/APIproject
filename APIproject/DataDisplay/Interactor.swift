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

class Interactor {

    private let funcForAPI = FuncForAPI()

    weak var presenter: InteractorOutputProtocol?
    
    required init(presenter: InteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension Interactor: InteractorInputProtocol {
    func getDataFromAPI(){
        
        funcForAPI.getData {[weak self] dataAPI, error in
                guard let self = self else { return }
                if let dataAPI = dataAPI {
                    let docs = dataAPI
                    self.presenter?.reciveData(data: docs)
                }
                if error != nil {
                    self.presenter?.reportABug(error: error!)
                    }
        }
    }
    
    func createDoc() {
        funcForAPI.postData {[weak self] dataAPI, error in
            guard let self = self else { return }
            if let dataAPI = dataAPI {
                let numberdoc = dataAPI.first!.number
                self.presenter?.documentWasCreated(with: numberdoc)
            }
            if error != nil {
                self.presenter?.reportABug(error: error!)
            }
        }
    }
}
