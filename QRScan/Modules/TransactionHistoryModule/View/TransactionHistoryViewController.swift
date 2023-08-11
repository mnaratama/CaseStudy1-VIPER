//
//  TransactionHistoryViewController.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol TransactionHistoryViewProtocol {
    func setTableView(with transactionData: [TransactionData])
    func displayNoTransaction()
}

class TransactionHistoryViewController: UIViewController, TransactionHistoryViewProtocol {
    
    var dataSource: UITableViewDiffableDataSource<TransactionSection, TransactionData>?
    var presenter: TransactionHistoryPresenterProtocol?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let noTransactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Anda belum memiliki riwayat transaksi"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        noTransactionLabel.isHidden = false
        setupLayout()
        setupTableView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.presentTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "transactionCell")
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<TransactionSection, TransactionData>(tableView: self.tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
            cell.configureCell(with: item)
            return cell
        }
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(noTransactionLabel)
        noTransactionLabel.anchorAllView(to: view)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func displayNoTransaction() {
        tableView.isHidden = true
        noTransactionLabel.isHidden = false
    }
    
    func setTableView(with transactionData: [TransactionData]) {
        tableView.isHidden = false
        noTransactionLabel.isHidden = true
        var snapShot = NSDiffableDataSourceSnapshot<TransactionSection, TransactionData>()
        snapShot.appendSections(TransactionSection.allCases)
        snapShot.appendItems(transactionData)
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}




extension TransactionHistoryViewController: UITableViewDelegate {
    
}
