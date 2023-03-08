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
}

protocol InteractorOutputProtocol: AnyObject {
    func reciveData(data: [Documents])
    
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
        
       // let docs = Documents(type: "1", number: "2", date: "3", status: true, delete: true, pred: "4")
       // presenter.reciveData(data: docs)
    }
    
    
    
    
}
