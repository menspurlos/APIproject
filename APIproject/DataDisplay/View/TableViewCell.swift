//
//  TableViewCell.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
   
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var numberLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var statusLabel: UILabel!
//    @IBOutlet weak var statusImage: UIImageView!
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        return label
    }()
    
    let statusImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    func setupTextLabel(label: UILabel) -> UILabel {
        label.textColor = .systemCyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
//        self.contentView.addSubview(statusImage)
//        self.contentView.addSubview(typeLabel)
//        self.contentView.addSubview(numberLabel)
//        self.contentView.addSubview(dateLabel)
//        self.contentView.addSubview(statusLabel)
        
        
        let stackViewY = UIStackView()
        stackViewY.axis = .vertical
        stackViewY.distribution = .equalSpacing
        stackViewY.addArrangedSubview(typeLabel)
        stackViewY.addArrangedSubview(numberLabel)
        stackViewY.addArrangedSubview(dateLabel)
       
        
        let stackViewX = UIStackView()
        stackViewX.axis = .horizontal
        stackViewX.addArrangedSubview(statusImage)
        stackViewX.addArrangedSubview(statusLabel)
        
        
        stackViewY.addArrangedSubview(stackViewX)
        
//        stackViewX.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//        }
        
        
        self.contentView.addSubview(stackViewY)
        stackViewY.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(15)
        }
        
        
//        typeLabel.snp.makeConstraints { make in
//            make.leading.trailing.top.bottom.equalToSuperview()
//        }
        
    }
    
    func set(object: Documents) {
        typeLabel.text = object.type
        numberLabel.text = object.number
        dateLabel.text = object.date
        if object.status == false {
            statusLabel.text = "Не проведён"
            statusImage.image = UIImage(named: "noprov")
        } else {
            statusLabel.text = "Проведён"
            statusImage.image = UIImage(named: "prov")
        }
        if object.delete == true {
            statusLabel.text = "Удален"
            statusImage.image = UIImage(named: "del")
        }
    }

}
