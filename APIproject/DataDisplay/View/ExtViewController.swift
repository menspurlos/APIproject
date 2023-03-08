//
//  ExtViewController.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit


extension ViewController {
    
    func initialize() {
        
        let tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        return tableView
            }()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        cell.set(object: docs[indexPath.row])
        
        //cell.set(object: docs[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
