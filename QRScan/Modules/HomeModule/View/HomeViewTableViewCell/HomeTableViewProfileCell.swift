//
//  HomeTableViewProfileCell.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import UIKit

class HomeTableViewProfileCell: UITableViewCell {

    let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 31, right: 0)
        return stackView
    }()
    
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Tama"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let saldoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(mainView)
        mainView.anchorAllView(to: contentView)
        mainView.addSubview(baseStackView)
        baseStackView.anchorAllView(to: mainView)
        baseStackView.addArrangedSubview(greetingLabel)
        baseStackView.addArrangedSubview(saldoLabel)
        
    }
    
    func configureCell(entity: HomeProfileCellEntity) {
        greetingLabel.text = "Halo, \(entity.name)"
        saldoLabel.text = "Saldo: Rp \(entity.saldo)"
    }
}
