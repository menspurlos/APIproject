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


class ViewController: UITableViewController {
    
    var docs: [Documents] = []
    var presenter: ViewOutPutProtocol!
    private let configurator: ConfiguratorInputProtocol = Configurator()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
        title = "Cписок документов"
        navigationController?.navigationBar.backgroundColor = .lightGray
        
        
        configurator.configure(with: self)
        presenter.prepareDataForDisplay()
        
//        let reloadButton = UIButton(type: .system)
//        reloadButton.addTarget(self, action: #selector(relodButtonTap), for: .touchUpInside)
        let menuBarButtonReload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(relodButtonTap))
        
//        let addButton = UIButton(type: .system)
//        addButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
//        let menuBarButtonAdd = UIBarButtonItem(customView: addButton)
        let menuBarButtonAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        
        navigationItem.rightBarButtonItem = menuBarButtonAdd
        navigationItem.leftBarButtonItem = menuBarButtonReload
        
      
    }
    
    @objc func relodButtonTap() {
        presenter.prepareDataForDisplay()
    }
    
    @objc func addButtonTap() {
        print ("клик2")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.set(object: docs[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}










