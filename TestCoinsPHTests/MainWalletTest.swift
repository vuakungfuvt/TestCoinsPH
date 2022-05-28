//
//  MainWalletTest.swift
//  TestCoinsPHTests
//
//  Created by tungphan on 28/05/2022.
//

import XCTest
@testable import TestCoinsPH

class MainWalletTest: XCTestCase {
    
    private let userDefaults = UserDefaults(suiteName: "MainWalletTest")!
    private let mockDataSuccess = CoinsPHMockDataSuccess()
    private let mockDataFailure = CoinsPHMockDataFailure()
    private var viewModel: MainWalletViewModel!

    override func setUp() {
        viewModel = MainWalletViewModel(userDefaults: userDefaults, dataAdapter: mockDataSuccess)
    }
    
    func testCallAPIGetMyWallet() {
        let adapter = mockDataSuccess
        viewModel.setAdapter(adapter: adapter)
        
        let successExpectation = expectation(description: "Test Call API Get My Wallet Success")
        viewModel.getMyWalletData { wallets in
            XCTAssertTrue(wallets.count > 0)
            successExpectation.fulfill()
        } failure: { _ in
            
        }
        wait(for: [successExpectation], timeout: 2)
        
        let failureAdapter = mockDataFailure
        viewModel.setAdapter(adapter: failureAdapter)
        let failureExpectation = expectation(description: "Test Call API Get My Wallet Failure")
        viewModel.getMyWalletData { _ in
            
        } failure: { error in
            XCTAssertNotNil(error)
            failureExpectation.fulfill()
        }
        wait(for: [failureExpectation], timeout: 2)
    }
    
    func testCallAPIGetTransactionHistories() {
        let adapter = mockDataSuccess
        viewModel.setAdapter(adapter: adapter)
        
        let successExpectation = expectation(description: "Test Call API Get TransactionHistories Success")
        viewModel.getHistoryTransactionData { transactions in
            XCTAssertTrue(transactions.count > 0)
            successExpectation.fulfill()
        } failure: { _ in
            
        }
        wait(for: [successExpectation], timeout: 2)
        
        let failureAdapter = mockDataFailure
        viewModel.setAdapter(adapter: failureAdapter)
        let failureExpectation = expectation(description: "Test Call API Get TransactionHistories Failure")
        viewModel.getHistoryTransactionData { _ in
            
        } failure: { error in
            XCTAssertNotNil(error)
            failureExpectation.fulfill()
        }
        wait(for: [failureExpectation], timeout: 2)
    }
    
    func testLoadtemWalletViewModels() {
        let adapter = mockDataSuccess
        viewModel.setAdapter(adapter: adapter)
        
        viewModel.itemMyWalletViewModels = []
        let successExpectation = expectation(description: "Test Load ItemWalletViewModels")
        viewModel.getMyWalletData { wallets in
            XCTAssertTrue(self.viewModel.itemMyWalletViewModels.count > 0)
            XCTAssertTrue(self.viewModel.itemMyWalletViewModels.count == wallets.count)
            
            for index in 0 ..< wallets.count {
                let wallet = wallets[index]
                let itemViewModel = self.viewModel.itemMyWalletViewModels[index]
                XCTAssertEqual(wallet.walletName, itemViewModel.coinName)
                XCTAssertEqual(wallet.balance, itemViewModel.coinPrice)
                XCTAssertEqual(wallet.imageUrl, itemViewModel.imageUrl)
            }
            
            successExpectation.fulfill()
        } failure: { _ in
            
        }
        wait(for: [successExpectation], timeout: 2)
    }
    
    func testLoadItemTransactionHistoryViewModel() {
        let adapter = mockDataSuccess
        viewModel.setAdapter(adapter: adapter)
        
        let successExpectation = expectation(description: "Test Load ItemTransactonHistoryViewModel")
        viewModel.getHistoryTransactionData { transactions in
            XCTAssertTrue(self.viewModel.itemTransactionViewModels.count > 0)
            XCTAssertTrue(self.viewModel.itemTransactionViewModels.count == transactions.count)
            successExpectation.fulfill()
            
            for index in 0 ..< transactions.count {
                let transaction = transactions[index]
                let itemViewModel = self.viewModel.itemTransactionViewModels[index]
                let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
                switch action {
                case .imcoming:
                    XCTAssertEqual(itemViewModel.contentTransaction, "\(transaction.recipient)'ve \(action.nameAction) a payment")
                    XCTAssertEqual(itemViewModel.quantityTransaction, "\(transaction.amount) \(transaction.currency)")
                case .outgoing:
                    XCTAssertEqual(itemViewModel.contentTransaction, "\(transaction.sender)'ve \(action.nameAction) to \(transaction.recipient)")
                    XCTAssertEqual(itemViewModel.quantityTransaction, "-\(transaction.amount) \(transaction.currency)")
                }
            }
        } failure: { _ in
            
        }
        wait(for: [successExpectation], timeout: 2)
    }
    
    func testGetTransaction() {
        let adapter = mockDataSuccess
        viewModel.setAdapter(adapter: adapter)
        
        let indexPath = IndexPath(row: 1, section: 0)
        
        let successExpectation = expectation(description: "Test Get TransactionHistories")
        viewModel.getHistoryTransactionData { transactions in
            
            let transactionEntity = transactions[indexPath.row]
            let transactionTest = self.viewModel.getTransaction(indexPath: indexPath)
            
            XCTAssertEqual(transactionTest.id, transactionEntity.id)
            XCTAssertEqual(transactionTest.recipient, transactionEntity.recipient)
            XCTAssertEqual(transactionTest.sender, transactionEntity.sender)
            XCTAssertEqual(transactionTest.currency, transactionEntity.currency)
            XCTAssertEqual(transactionTest.amount, transactionEntity.amount)
            XCTAssertEqual(transactionTest.entry, transactionEntity.entry)
            
            successExpectation.fulfill()
        } failure: { _ in
            
        }
        wait(for: [successExpectation], timeout: 2)
    }

}
