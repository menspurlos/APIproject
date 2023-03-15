//
//  configurator.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import Foundation

protocol ConfiguratorInputProtocol {
    func configure(with view: ViewController)
}

class Configurator: ConfiguratorInputProtocol {
    func configure(with view: ViewController) {
        let presenter = Presenter(view: view)
        let interactor = Interactor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
