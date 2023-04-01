//
//  MainInteractor.swift
//  APIproject
//
//  Created by macBook on 01.04.2023.
//  
//

import Foundation

// MARK: Protocol - MainPresenterToInteractorProtocol (Presenter -> Interactor)
protocol MainPresenterToInteractorProtocol: AnyObject {
    func getDataFromAPI()
    func createDoc()
}

class MainInteractor {

    // MARK: Properties
    weak var presenter: MainInteractorToPresenterProtocol!
    private let funcForAPI = FuncForAPI()
}

// MARK: Extension - MainPresenterToInteractorProtocol
extension MainInteractor: MainPresenterToInteractorProtocol {
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
