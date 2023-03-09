//
//  Presenter.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit
import Alamofire

class Presenter: ViewOutPutProtocol {
   
    unowned let view: ViewInputProtocol
    var interactor: InteractorInputProtocol!
    
    required init(view: ViewInputProtocol) {
        self.view = view
    }
    
    func prepareDataForDisplay() {
        interactor.getDataFromAPI()
    }
    
    func buttonAddTapAction() {
        interactor.createDoc()
    }
}

extension Presenter: InteractorOutputProtocol {
    func reportABug(error: Alamofire.AFError) {
        //тут можно разобрать error, но сообщаем просто, что есть ошибка
        self.view.alertShow(text: "Отсутствует подключение к серверу или на сервере неккоректные данные", title: "Error")  
    }
    
    func documentWasCreated(with number: String) {
        view.alertShow(text: "document was created, number \(number)", title: "Create Doc")  //сообщить, что был создан документ
        interactor.getDataFromAPI()                                                         //получить данные с сервера и показать
    }
    
    func reciveData(data: [Documents]) {
        let dataForDisplay = prepareDataFromAPI(data: data)  //подготовить полученные данные
        view.reloadView(dataForDisplay)                     //передать на view
    }
    
    
    //преобразование полученных данных по API для отображения
    func prepareDataFromAPI(data: [Documents]) -> [DataForDisplay] {
        var dataForDisplay: [DataForDisplay] = []
        var status = ""
        var image = UIImage()
        
        data.forEach { doc in
            if doc.status == false {
                status = "Не проведён"
                image = UIImage(named: "noprov")!
            } else {
                status = "Проведён"
                image  = UIImage(named: "prov")!
            }
            if doc.delete == true {
                status = "Удален"
                image  = UIImage(named: "del")!
            }
            
            let addedDocs = DataForDisplay(type: doc.type,
                                           number: doc.number,
                                           date: doc.date,
                                           status: status,
                                           image: image)
            
            dataForDisplay.append(addedDocs)
        }  
    return dataForDisplay
    }
}
