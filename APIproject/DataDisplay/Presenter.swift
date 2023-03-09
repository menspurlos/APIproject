//
//  Presenter.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

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
    func documentWasCreated(with number: String) {
        view.alertShow(text: "document was created, number \(number)", title: "Create Doc")
        interactor.getDataFromAPI()
    }
    
    func reciveData(data: [Documents]) {
        let dataForDisplay = prepareDataFromAPI(data: data)
        view.reloadView(dataForDisplay)
    }
    
    func prepareDataFromAPI(data: [Documents]) -> [DataForDisplay] {
        var dataForDisplay: [DataForDisplay] = []
        var status = ""
        var image = UIImage()
        
        for index in 0 ... data.count - 1 {
            
            if data[index].status == false {
                status = "Не проведён"
                image = UIImage(named: "noprov")!
            } else {
                status = "Проведён"
                image  = UIImage(named: "prov")!
            }
            if data[index].delete == true {
                status = "Удален"
                image  = UIImage(named: "del")!
            }
            
            let addedDocs = DataForDisplay(type: data[index].type,
                                           number: data[index].number,
                                           date: data[index].date,
                                           status: status,
                                           image: image)
            
            dataForDisplay.append(addedDocs)
            
        }
    return dataForDisplay
    }
    
    
    
}
