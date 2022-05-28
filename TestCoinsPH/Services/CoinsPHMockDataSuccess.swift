//
//  CoinsPHMockDataSuccess.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import UIKit

class CoinsPHMockDataSuccess: DataAdapter {
    func getMyWalletData(success: @escaping (([Wallet]) -> Void), failure: @escaping ((Error?) -> Void)) {
        guard let path = Bundle.main.path(forResource: "getMyWallets", ofType: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let coin = try JSONDecoder().decode(Coin.self, from: data)
            success(coin.wallets)
        } catch (let error) {
            failure(error)
        }
    }
    
    func getHistoryTransactionData(success: @escaping (([Transaction]) -> Void), failure: @escaping ((Error?) -> Void)) {
        guard let path = Bundle.main.path(forResource: "getHistoryTransactions", ofType: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let historyTransaction = try JSONDecoder().decode(HistoryTransaction.self, from: data)
            success(historyTransaction.histories)
        } catch (let error) {
            failure(error)
        }
    }
    

}
