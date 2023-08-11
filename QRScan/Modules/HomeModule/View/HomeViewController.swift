//
//  HomeViewController.swift
//  QRScan
//
//  Created by Naratama on 11/08/23.
//

import UIKit

protocol HomeViewProtocol {
    func setFirstTableView()
}

class HomeViewController: UIViewController {
    
    var homePresenter: HomePresenterProtocol?
    var dataSource: UITableViewDiffableDataSource<HomeSection, AnyHashable>?
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenter?.presentTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewProfileCell.self, forCellReuseIdentifier: "profile")
        tableView.register(HomeTableMenuCell.self, forCellReuseIdentifier: "menu")
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<HomeSection, AnyHashable>(tableView: self.tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            if let profileItem = item as? HomeProfileCellEntity {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as? HomeTableViewProfileCell else {
                    return UITableViewCell()
                }
                cell.configureCell(entity: profileItem)
                return cell
            } else if let menuItem = item as? HomeMenuEntity {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? HomeTableMenuCell else {
                    return UITableViewCell()
                }
                cell.configureCell(menu: menuItem)
                return cell
                
            } else {
                return UITableViewCell()
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(mainView)
        mainView.anchorAllView(to: view)
        mainView.addSubview(tableView)
        tableView.anchorAllViewWith16Constant(to: mainView)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeTableMenuCell else {
            return
        }
        if cell.menu?.identifier == "pay" {
            homePresenter?.presentToScanQR()
        } else if cell.menu?.identifier == "history" {
            homePresenter?.presentToHistoryTransaction()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func setFirstTableView() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, AnyHashable>()
        snapshot.appendSections(HomeSection.allCases)
        HomeSection.allCases.forEach({
            if $0 == .profile {
                let saldo = UserDefaults.standard.integer(forKey: "userSaldo")
                snapshot.appendItems([HomeProfileCellEntity(name: "Tama", saldo: "\(saldo)")], toSection: .profile)
            } else if $0 == .menu {
                let menu = [HomeMenuEntity(identifier: "pay", menuName: "Bayar (Scan QR)"),
                            HomeMenuEntity(identifier: "history", menuName: "Riwayat Transaksi")]
                snapshot.appendItems(menu, toSection: .menu)
            }
        })
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
