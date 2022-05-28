//
//  CoinsPHMockDataFailure.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation

class CoinsPHMockDataFailure: DataAdapter {
    func getMyWalletData(success: @escaping (([Wallet]) -> Void), failure: @escaping ((Error?) -> Void)) {
        let error = NSError(domain: "Request has been throttled", code: 505, userInfo: nil)
        failure(error)
    }
    
    func getHistoryTransactionData(success: @escaping (([Transaction]) -> Void), failure: @escaping ((Error?) -> Void)) {
        let error = NSError(domain: "Request has been throttled", code: 505, userInfo: nil)
        failure(error)
    }

}
