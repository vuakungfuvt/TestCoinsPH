//
//  MainWalletViewModel.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

enum MainWalletSection {
    case myWallet
    case history
    
    var titleSection: String {
        switch self {
        case .myWallet:
            return "My Wallets"
        case .history:
            return "History"
        }
    }
}

enum TransactionAction: String {
    case imcoming
    case outgoing
    
    var nameAction: String {
        switch self {
        case .imcoming:
            return "received"
        case .outgoing:
            return "cashed out to"
        }
    }
}

class MainWalletViewModel {
    
    // MARK: - Variables
    var sectionTypes: [MainWalletSection] = [.myWallet, .history]
    var itemMyWalletViewModels: [ItemMyWalletCellViewModel] = [ItemMyWalletCellViewModel]()
    var itemTransactionViewModels: [ItemTransactionCellViewModel] = [ItemTransactionCellViewModel]()
    fileprivate var wallet: [Wallet] = [Wallet]()
    fileprivate var transactions: [Transaction] = [Transaction]()
    fileprivate var userDefaults: UserDefaults!
    fileprivate var dataAdapter: DataAdapter!
    var reloadTableView: (() -> Void)?

    init(userDefaults: UserDefaults, dataAdapter: DataAdapter) {
        self.userDefaults = userDefaults
        self.dataAdapter = dataAdapter
    }
    
    func setAdapter(adapter: DataAdapter) {
        self.dataAdapter = adapter
    }
    
    func getMyWalletData(success: @escaping (([Wallet]) -> Void), failure: @escaping ((Error?) -> Void)) {
        dataAdapter.getMyWalletData { wallets in
            self.wallet = wallets
            self.loadItemWalletViewModels(wallets: wallets)
            success(wallets)
        } failure: { error in
            failure(error)
        }
    }
   
    func getHistoryTransactionData(success: @escaping (([Transaction]) -> Void), failure: @escaping ((Error?) -> Void)) {
        dataAdapter.getHistoryTransactionData { transactions in
            self.transactions = transactions
            self.loadItemTransactionHistoryViewModel(transaction: transactions)
            success(transactions)
        } failure: { error in
            failure(error)
        }
    }
    
    func loadItemWalletViewModels(wallets: [Wallet]) {
        var itemViewModels = [ItemMyWalletCellViewModel]()
        wallets.forEach {
            let coinImage = ""
            let coinName = $0.walletName
            let coinPrice = $0.balance
            let imageUrl = $0.imageUrl
            let itemVM = ItemMyWalletCellViewModel(coinImage: coinImage, coinName: coinName, coinPrice: coinPrice, imageUrl: imageUrl)
            itemViewModels.append(itemVM)
        }
        self.itemMyWalletViewModels = itemViewModels
    }
    
    func loadItemTransactionHistoryViewModel(transaction: [Transaction]) {
        var itemViewModels = [ItemTransactionCellViewModel]()
        transactions.forEach {
            let action = TransactionAction(rawValue: $0.entry) ?? .imcoming
            var descriptionName: String = ""
            var quantityTransaction: String = ""
            switch action {
            case .imcoming:
                descriptionName = "\($0.recipient)'ve \(action.nameAction) a payment"
                quantityTransaction = "\($0.amount) \($0.currency)"
            case .outgoing:
                descriptionName = "\($0.sender)'ve \(action.nameAction) to \($0.recipient)"
                quantityTransaction = "-\($0.amount) \($0.currency)"
            }
            let itemVM = ItemTransactionCellViewModel(contentTransaction: descriptionName, quantityTransaction: quantityTransaction)
            itemViewModels.append(itemVM)
        }
        self.itemTransactionViewModels = itemViewModels
    }
    
    func loadAllData(success: @escaping (() -> Void), failure: @escaping ((Error?) -> Void)) {
        let group = DispatchGroup()
        var error: Error?
       
        group.enter()
        getMyWalletData { _ in
            group.leave()
        } failure: { err in
            error = err
            group.leave()
        }
        
        group.enter()
        getHistoryTransactionData { _ in
            group.leave()
        } failure: { err in
            error = err
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = error {
                failure(error)
                return
            }
            self.reloadTableView?()
            success()
        }
    }
    
    func getTransaction(indexPath: IndexPath) -> Transaction {
        return transactions[indexPath.row]
    }
}
