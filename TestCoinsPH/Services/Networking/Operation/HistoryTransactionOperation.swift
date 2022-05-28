//
//  HistoryTransactionOperation.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation
class HistoryTransactionOperation: BaseOperation<HistoryTransaction> {
    override var path: String {
        return "histories"
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    init(completion: @escaping (Result<HistoryTransaction, APIError>) -> Void) {
        let params = [:] as [String : Any]
        super.init(encodingType: .url,
                   urlParameters: params,
                   bodyParameters: [:],
                   maximumRetryCount: 0,
                   decodingStrategy: .normal,
                   completionQueue: .main,
                   completion: completion)
    }
}
