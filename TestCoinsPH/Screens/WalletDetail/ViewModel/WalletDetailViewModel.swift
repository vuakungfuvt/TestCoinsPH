//
//  WalletDetailViewModel.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class WalletDetailViewModel {

    private var transaction: Transaction!
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    func getContentTransaction() -> String {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            return "\(transaction.recipient)'ve \(action.nameAction) a payment."
        case .outgoing:
            return "\(transaction.sender)'ve \(action.nameAction) to \(transaction.recipient)."
        }
    }
    
    func getOtherRole() -> String {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            return "Sender"
        case .outgoing:
            return "Receiver"
        }
    }
    
    func getOtherRoleContent() -> String {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            return "\(transaction.sender)"
        case .outgoing:
            return "\(transaction.recipient)"
        }
    }
    
    func getAmount() -> String {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            return "\(transaction.amount) \(transaction.currency)"
        case .outgoing:
            return "-\(transaction.amount) \(transaction.currency)"
        }
    }
    
}
