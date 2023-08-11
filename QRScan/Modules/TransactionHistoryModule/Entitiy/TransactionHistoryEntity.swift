//
//  TransactionHistoryEntity.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import Foundation

enum TransactionSection: CaseIterable {
    case transaction
}

enum TransactionType: String {
    case qr
}

struct TransactionData: Hashable {
    let uuid = UUID()
    let transactionType: TransactionType
    let transactionDate: Date
    let amount: Int
}
