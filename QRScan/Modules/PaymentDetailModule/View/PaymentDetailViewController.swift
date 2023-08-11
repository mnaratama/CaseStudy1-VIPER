//
//  PaymentDetailViewController.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit
import TTGSnackbar

protocol PaymentDetailViewProtocol {
    func displayPaymentDetail(viewModel: PaymentDetailEntity)
    func displayPaymentSuccess()
    func displayPaymentFailed(info: String)
}

class PaymentDetailViewController: UIViewController, PaymentDetailViewProtocol {

    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    let bankOriginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    let transactionCodeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    
    let merchantNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    
    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    
    let bankOriginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let transactionCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let merchantNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let bankOriginLabelValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let transactionCodeLabelValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let merchantNameLabelValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let priceLabelValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    let payButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Bayar", for: .normal)
        return button
    }()
    
    var presenter: PaymentDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupPayButton()
        presenter?.presentPaymentDetail()
    }
    
    func displayPaymentFailed(info: String) {
        DispatchQueue.main.async {
            let snackBar = TTGSnackbar(message: info, duration: .middle)
            snackBar.animationType = .slideFromTopBackToTop
            snackBar.backgroundColor = .red
            snackBar.show()
        }
    }
    
    func displayPaymentDetail(viewModel: PaymentDetailEntity) {
        DispatchQueue.main.async { [self] in
            bankOriginLabel.text = "Asal Bank"
            bankOriginLabelValue.text = viewModel.bankOrigin
            
            transactionCodeLabel.text = "ID Transaksi"
            transactionCodeLabelValue.text = viewModel.transactionCode
            
            merchantNameLabel.text = "Nama Merchant"
            merchantNameLabelValue.text = viewModel.merchantName
            
            priceLabel.text = "Tagihan"
            priceLabelValue.text = "Rp \(viewModel.price)"
        }
    }
    
    func displayPaymentSuccess() {
        DispatchQueue.main.async { [self] in
            let snackBar = TTGSnackbar(message: "Pembayaran Sukses!", duration: .middle)
            snackBar.animationType = .slideFromTopBackToTop
            snackBar.backgroundColor = .green
            snackBar.show()
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func setupPayButton() {
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(baseStackView)
        baseStackView.anchorAllView(to: view)
        
        baseStackView.addArrangedSubview(bankOriginStackView)
        bankOriginStackView.addArrangedSubview(bankOriginLabel)
        bankOriginStackView.addArrangedSubview(bankOriginLabelValue)
        
        baseStackView.addArrangedSubview(transactionCodeStackView)
        transactionCodeStackView.addArrangedSubview(transactionCodeLabel)
        transactionCodeStackView.addArrangedSubview(transactionCodeLabelValue)
        
        baseStackView.addArrangedSubview(merchantNameStackView)
        merchantNameStackView.addArrangedSubview(merchantNameLabel)
        merchantNameStackView.addArrangedSubview(merchantNameLabelValue)
        
        baseStackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceLabelValue)
        
        baseStackView.addArrangedSubview(spacerView)
        baseStackView.addArrangedSubview(payButton)
    }
    
    @objc func payButtonTapped() {
        presenter?.checkPayment()
    }
}
