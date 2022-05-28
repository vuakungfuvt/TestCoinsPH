//
//  CoinsPHAPI.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation

class CoinsPHAPI: NSObject, DataAdapter {
    
    private var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .background
        return queue
    }()
    
    func getMyWalletData(success: @escaping (([Wallet]) -> Void), failure: @escaping ((Error?) -> Void)) {
        let operation = MyWalletOperation { result in
            switch result {
            case .success(let coin):
                success(coin.wallets)
            case .failure(let error):
                failure(error)
            }
        }
        operationQueue.addOperation(operation)
    }
    
    func getHistoryTransactionData(success: @escaping (([Transaction]) -> Void), failure: @escaping ((Error?) -> Void)) {
        let operation = HistoryTransactionOperation { result in
            switch result {
            case .success(let history):
                success(history.histories)
            case .failure(let error):
                failure(error)
            }
        }
        operationQueue.addOperation(operation)
    }
    
}
