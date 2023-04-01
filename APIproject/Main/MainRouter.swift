//
//  MainRouter.swift
//  APIproject
//
//  Created by macBook on 01.04.2023.
//  
//

import Foundation

// MARK: Protocol - MainPresenterToRouterProtocol (Presenter -> Router)
protocol MainPresenterToRouterProtocol: AnyObject {

}

class MainRouter {

    // MARK: Properties
    weak var view: MainRouterToViewProtocol!
}

// MARK: Extension - MainPresenterToRouterProtocol
extension MainRouter: MainPresenterToRouterProtocol {
    
}