//
//  DataAdapter.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation

protocol DataAdapter {
    func getMyWalletData(success: @escaping (([Wallet]) -> Void), failure: @escaping ((Error?) -> Void))
    func getHistoryTransactionData(success: @escaping (([Transaction]) -> Void), failure: @escaping ((Error?) -> Void))
}
