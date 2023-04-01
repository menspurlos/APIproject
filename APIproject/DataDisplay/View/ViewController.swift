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

class ViewController: UIViewController {
    
    var docs: [DataForDisplay] = []
    var presenter: ViewOutPutProtocol!
    private let configurator: ConfiguratorInputProtocol = Configurator()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
        }()
    
    private var dataSource: UITableViewDiffableDataSource<Section,DataForDisplay>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDataSource()
        tableView.dataSource = dataSource
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        navigationControllerConfigure()
        
        configurator.configure(with: self)
        presenter.prepareDataForDisplay()
        
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
            self.relData()
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
    
    func relData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,DataForDisplay>()
        snapshot.appendSections([.first])
        snapshot.appendItems(docs)
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func createDataSource() {
        dataSource = UITableViewDiffableDataSource<Section,DataForDisplay>(tableView: tableView) { tableView, indexPath, row in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
            cell.set(object: self.docs[indexPath.row])
            return cell
            }
    }
}









