//
//  MyWalletOperation.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation
class MyWalletOperation: BaseOperation<Coin> {
    override var path: String {
        return "wallets"
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    init(completion: @escaping (Result<Coin, APIError>) -> Void) {
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
