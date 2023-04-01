//
//  ViewController.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit
import SnapKit

protocol ViewInputProtocol: AnyObject {
    func reloadView(_ docs: [DataForDisplay])
    func alertShow(text: String, title: String)
}

    //тут ветка без тэйбла

class ViewController: UIViewController {
    
    var docs: [DataForDisplay] = []
    var presenter: ViewOutPutProtocol!
    private let configurator: ConfiguratorInputProtocol = Configurator()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        return tableView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationControllerConfigure()
        
        configurator.configure(with: self)
        presenter.prepareDataForDisplay()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.set(object: docs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension ViewController: ViewInputProtocol {
    
    func alertShow(text: String, title: String) {
        let alertController = UIAlertController(title: title,
                                                message: text,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func reloadView(_ docs: [DataForDisplay]) {
        self.docs = docs
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

private extension ViewController {
    func navigationControllerConfigure(){
        
        title = "Cписок документов"
        navigationController?.navigationBar.backgroundColor = .lightGray
        
        let menuBarButtonReload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(relodButtonTap))
        let menuBarButtonAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        
        navigationItem.rightBarButtonItem = menuBarButtonAdd
        navigationItem.leftBarButtonItem = menuBarButtonReload
    }
    
    @objc func relodButtonTap() {
        presenter.prepareDataForDisplay()
    }
    
    @objc func addButtonTap() {
        presenter.buttonAddTapAction()
    }
}









