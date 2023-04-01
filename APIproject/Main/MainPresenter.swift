//
//  MainPresenter.swift
//  APIproject
//
//  Created by macBook on 01.04.2023.
//  
//

import UIKit
import Alamofire

// MARK: Protocol - MainViewToPresenterProtocol (View -> Presenter)
protocol MainViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func prepareDataForDisplay()
    func buttonAddTapAction()
}

// MARK: Protocol - MainInteractorToPresenterProtocol (Interactor -> Presenter)
protocol MainInteractorToPresenterProtocol: AnyObject {
    func reciveData(data: [Documents])
    func documentWasCreated(with number: String)
    func reportABug(error: AFError)
}

class MainPresenter {

    // MARK: Properties
    var router: MainPresenterToRouterProtocol!
    var interactor: MainPresenterToInteractorProtocol!
    weak var view: MainPresenterToViewProtocol!
}

// MARK: Extension - MainViewToPresenterProtocol
extension MainPresenter: MainViewToPresenterProtocol {
    func viewDidLoad() {
    }
    
    func prepareDataForDisplay() {
         interactor.getDataFromAPI()
    }
    
    func buttonAddTapAction() {
         interactor.createDoc()
    }
    
    
}

// MARK: Extension - MainInteractorToPresenterProtocol
extension MainPresenter: MainInteractorToPresenterProtocol {
        func reportABug(error: Alamofire.AFError) {
            //тут можно разобрать error, но сообщаем просто, что есть ошибка
            view?.alertShow(text: "Отсутствует подключение к серверу или на сервере неккоректные данные", title: "Error")
        }
    
        func documentWasCreated(with number: String) {
            view?.alertShow(text: "document was created, number \(number)", title: "Create Doc")  //сообщить, что был создан документ
            interactor.getDataFromAPI()                                                         //получить данные с сервера и показать
        }
    
        func reciveData(data: [Documents]) {
            let dataForDisplay = prepareDataFromAPI(data: data)  //подготовить полученные данные
            view?.reloadView(dataForDisplay)                     //передать на view
        }
}

private extension MainPresenter {
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
