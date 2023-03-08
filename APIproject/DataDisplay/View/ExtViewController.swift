//
//  ExtViewController.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

extension ViewController: ViewInputProtocol {
    func reloadView(_ docs: [Documents]) {
        self.docs = docs
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
 
extension ViewController {
    
    func allertShow(text: String, title: String) {
    
        let alertController = UIAlertController(title: title,
                                                message: text,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
