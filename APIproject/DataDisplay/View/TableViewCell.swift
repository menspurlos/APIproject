//
//  TableViewCell.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
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
  
        self.contentView.addSubview(stackViewY)
        stackViewY.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(15)
        }
        
    }
    
    func set(object: DataForDisplay) {
        typeLabel.text = object.type
        numberLabel.text = object.number
        dateLabel.text = object.date
        statusLabel.text = object.status
        statusImage.image = object.image
    }

}
