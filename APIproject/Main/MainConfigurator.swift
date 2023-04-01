//
//  MainConfigurator.swift
//  APIproject
//
//  Created by macBook on 01.04.2023.
//  
//

import UIKit

class MainConfigurator {
    func configure() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()
        let interactor = MainInteractor()
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}