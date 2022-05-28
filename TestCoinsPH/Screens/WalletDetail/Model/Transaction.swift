//
//  Transaction.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation

// MARK: - HistoryTransaction
struct HistoryTransaction: Codable {
    let histories: [Transaction]
}

// MARK: - Transaction
struct Transaction: Codable {
    let id, entry, amount, currency: String
    let sender, recipient: String
}
