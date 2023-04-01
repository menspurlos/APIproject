//
//  MainViewController.swift
//  APIproject
//
//  Created by macBook on 01.04.2023.
//  
//

import UIKit
import SnapKit

// MARK: Protocol - MainPresenterToViewProtocol (Presenter -> View)
protocol MainPresenterToViewProtocol: AnyObject {
    func reloadView(_ docs: [DataForDisplay])
    func alertShow(text: String, title: String)
}

// MARK: Protocol - MainRouterToViewProtocol (Router -> View)
protocol MainRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class MainViewController: UIViewController {
    
    // MARK: - Property
    var presenter: MainViewToPresenterProtocol!
    var docs: [DataForDisplay] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
        }()
    
    private var dataSource: UITableViewDiffableDataSource<Section,DataForDisplay>?

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {
        
    }

    private func configureUI() {
        createDataSource()
        tableView.dataSource = dataSource
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        navigationControllerConfigure()
        presenter.prepareDataForDisplay()
    }
}

// MARK: Extension - MainPresenterToViewProtocol 
extension MainViewController: MainPresenterToViewProtocol{
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

// MARK: Extension - MainRouterToViewProtocol
extension MainViewController: MainRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: Etension - different funcution
private extension MainViewController {
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
