//
//  WalletDetailTest.swift
//  TestCoinsPHTests
//
//  Created by tungphan on 29/05/2022.
//

import XCTest
@testable import TestCoinsPH

class WalletDetailTest: XCTestCase {

    private let transaction = Transaction(id: "1", entry: "outgoing", amount: "10", currency: "LUNA", sender: "Tung", recipient: "Thanh")
    private var viewModel: WalletDetailViewModel!
    
    override func setUp() {
        viewModel = WalletDetailViewModel(transaction: transaction)
    }
    
    func testGetContentTransaction() {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            XCTAssertEqual(viewModel.getContentTransaction(), "\(transaction.recipient)'ve \(action.nameAction) a payment.")
        case .outgoing:
            XCTAssertEqual(viewModel.getContentTransaction(), "\(transaction.sender)'ve \(action.nameAction) to \(transaction.recipient).")
        }
    }
    
    func testGetOtherRole() {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            XCTAssertEqual(viewModel.getOtherRole(), "Sender")
        case .outgoing:
            XCTAssertEqual(viewModel.getOtherRole(),"Receiver")
        }
    }
    
    func testGetOtherRoleContent() {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            XCTAssertEqual(viewModel.getOtherRoleContent(), "\(transaction.sender)")
        case .outgoing:
            XCTAssertEqual(viewModel.getOtherRoleContent(), "\(transaction.recipient)")
        }
    }
    
    func testGetAmount() {
        let action = TransactionAction(rawValue: transaction.entry) ?? .imcoming
        switch action {
        case .imcoming:
            XCTAssertEqual(viewModel.getAmount(), "\(transaction.amount) \(transaction.currency)")
        case .outgoing:
                            XCTAssertEqual(viewModel.getAmount(), "-\(transaction.amount) \(transaction.currency)")
        }
    }
    

}
