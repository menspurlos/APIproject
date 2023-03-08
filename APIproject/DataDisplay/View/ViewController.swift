//
//  ViewController.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit
import SnapKit

protocol ViewInputProtocol: AnyObject {
    func reloadView(_ docs: [Documents])
}

protocol ViewOutPutProtocol {
    init(view: ViewInputProtocol)
    func prepareDataForDisplay()
}


class ViewController: UIViewController {
    var docs: [Documents] = []
    private var tableView: UITableView!
    var presenter: ViewOutPutProtocol!
    private let configurator: ConfiguratorInputProtocol = Configurator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        initialize()
        presenter.prepareDataForDisplay()
        
        
    }
    
    
    func rel(data: [Documents]) {

                self.docs = data
                DispatchQueue.main.async {
                 
                    self.tableView.reloadData()
                }

    }
    
}

extension ViewController: ViewInputProtocol {
    
    func reloadView(_ docs: [Documents]) {
        rel(data: docs)
    }
}






