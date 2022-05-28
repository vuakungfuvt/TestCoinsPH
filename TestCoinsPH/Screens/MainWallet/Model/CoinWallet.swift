//
//  CoinWallet.swift
//  TestCoinsPH
//
//  Created by tungphan on 28/05/2022.
//

import Foundation

// MARK: - Coin
struct Coin: Codable {
    let wallets: [Wallet]
}

// MARK: - Wallet
struct Wallet: Codable {
    let id, walletName, balance, imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case walletName = "wallet_name"
        case balance
        case imageUrl
    }
}
