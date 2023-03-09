//
//  ExtViewController.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

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
 
extension ViewController {
    
//    func allertShow(text: String, title: String) {
//
//        let alertController = UIAlertController(title: title,
//                                                message: text,
//                                                preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
//
//        alertController.addAction(cancelAction)
//        present(alertController, animated: true)
//    }
    
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
