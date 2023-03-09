//
//  Interactor.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Foundation


protocol InteractorInputProtocol {
    init(presenter: InteractorOutputProtocol)
    func getDataFromAPI()
    func createDoc()
}

protocol InteractorOutputProtocol: AnyObject {
    func reciveData(data: [Documents])
    func documentWasCreated(with number: String)
    
}

class Interactor: InteractorInputProtocol {

    let funcForAPI = FuncForAPI()

    unowned let presenter: InteractorOutputProtocol
    
    required init(presenter: InteractorOutputProtocol) {
        self.presenter = presenter
    }
   
    func getDataFromAPI(){
        
        funcForAPI.GetData {dataAPI, error in
                if let dataAPI = dataAPI {
                    let docs = dataAPI
                    self.presenter.reciveData(data: docs)
                }
                if error != nil {
                    print (error as Any)
                    //self.allertShow(text: "Отсутствует подключение к серверу или на сервере неккоректные данные", title: "Error")
                    }
        }
    }
    
    func createDoc() {
        funcForAPI.PostData {dataAPI, error in
            if let dataAPI = dataAPI {
                let numberdoc = dataAPI.first!.number
                self.presenter.documentWasCreated(with: numberdoc)
            }
            if error != nil {
//                self.allertShow(text: "Отсутствует подключение к серверу или на сервере неккоректные данные", title: "Error")
            }
        }
    }
    
    
    
    
    
    
}
