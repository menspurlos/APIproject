//
//  TableViewCell.swift
//  APIproject
//
//  Created by macBook on 08.03.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    private let typeLabel = UILabel()
    private let numberLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let nameTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Вид документа"
        return label
    }()
    
    private let nameNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер"
        return label
    }()
    
    private let nameDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        return label
    }()
    
    private let nameStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус документа"
        return label
    }()
    
    private let statusImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextLabel(label: [typeLabel, numberLabel, dateLabel, statusLabel])
        setupImmutableLabel(label: [nameTypeLabel, nameNumberLabel, nameDateLabel, nameStatusLabel])
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
                typeLabel.text = ""
                numberLabel.text = ""
                dateLabel.text = ""
                statusLabel.text = ""
                statusImage.image = nil
        }
    
    func set(object: DataForDisplay) {
        typeLabel.text = object.type
        numberLabel.text = object.number
        dateLabel.text = object.date
        statusLabel.text = object.status
        statusImage.image = object.image
    }
}

private extension TableViewCell {
    func setupTextLabel(label: [UILabel]) {
        label.forEach { label in
            label.textColor = .systemCyan
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupImmutableLabel(label: [UILabel]) {
        label.forEach { label in
            label.textColor = .systemTeal
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupUI() {

        // Отображение статуса Горизонтальный стек
        let stackViewXForStatus = UIStackView()
        stackViewXForStatus.axis = .horizontal
        stackViewXForStatus.addArrangedSubview(statusLabel)
        stackViewXForStatus.addArrangedSubview(statusImage)
       
        // Наименовение отображаемых данных Вертикальный стек
        let stackViewYNameTextLabel = UIStackView()
        stackViewYNameTextLabel.axis = .vertical
        stackViewYNameTextLabel.distribution = .equalSpacing
        stackViewYNameTextLabel.addArrangedSubview(nameTypeLabel)
        stackViewYNameTextLabel.addArrangedSubview(nameNumberLabel)
        stackViewYNameTextLabel.addArrangedSubview(nameDateLabel)
        stackViewYNameTextLabel.addArrangedSubview(nameStatusLabel)
        
        // отображение данных Вертикальный стек
        let stackViewYTextLabel = UIStackView()
        stackViewYTextLabel.axis = .vertical
        stackViewYTextLabel.distribution = .equalSpacing
        stackViewYTextLabel.addArrangedSubview(typeLabel)
        stackViewYTextLabel.addArrangedSubview(numberLabel)
        stackViewYTextLabel.addArrangedSubview(dateLabel)
        stackViewYTextLabel.addArrangedSubview(stackViewXForStatus)

        //отображение общего стека
        let generalStackView = UIStackView()
        generalStackView.axis = .horizontal
        generalStackView.addArrangedSubview(stackViewYNameTextLabel)
        generalStackView.addArrangedSubview(stackViewYTextLabel)
  
        self.contentView.addSubview(generalStackView)
        generalStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(15)
        }
    }
}
