//
//  Presenter.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//


class Presenter: ViewOutPutProtocol {
    
    
    unowned let view: ViewInputProtocol
    var interactor: InteractorInputProtocol!
    
    required init(view: ViewInputProtocol) {
        self.view = view
    }
    
    
    
    func prepareDataForDisplay() {
        interactor.getDataFromAPI()
        //interactor.createDoc()
    }
    


}


extension Presenter: InteractorOutputProtocol {
    func reciveData(data: [Documents]) {
        view.reloadView(data)
    }
    
    
}
