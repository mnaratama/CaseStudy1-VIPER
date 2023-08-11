//
//  TransactionTableViewCell.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    let baseView: UIView = {
        let view = UIView()
        return view
    }()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let typeAndDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let transactionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let transactionDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with transactionData: TransactionData) {
        switch transactionData.transactionType {
        case .qr:
            transactionTypeLabel.text = "Pembayaran QR"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        transactionDateLabel.text = dateFormatter.string(from: transactionData.transactionDate)
        amountLabel.text = "Rp \(transactionData.amount)"
        
    }
    
    private func setupLayout() {
        contentView.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        baseView.addSubview(baseStackView)
        baseStackView.anchorAllView(to: baseView)
        
        baseStackView.addArrangedSubview(typeAndDateStackView)
        typeAndDateStackView.addArrangedSubview(transactionTypeLabel)
        typeAndDateStackView.addArrangedSubview(transactionDateLabel)
        
        baseStackView.addArrangedSubview(amountLabel)
    }
}
