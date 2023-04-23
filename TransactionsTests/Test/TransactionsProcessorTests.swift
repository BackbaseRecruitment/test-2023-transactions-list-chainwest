//
//  TransactionsProcessorTests.swift
//  TransactionsTests
//
//  Created by Евгений Урбановский on 4/23/23.
//

import XCTest
@testable import Transactions

final class TransactionsProcessorTests: XCTestCase {
    var sut: TransactionsProcessor!

    override func setUp() {
        super.setUp()
        sut = TransactionsProcessorImpl()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testProcessTransactions_WithOneTransactions_ReturnsOneTransactions() {
        let transactions = [
            TransactionDTO(description: ["Transaction 1"], amount: 100, currencyCode: .euro, creditDebitIndicator: .credit, creationTime: Date(), section: .pending),
        ]

        let processedTransactions = sut.processTransactions(transactions)

        XCTAssertEqual(processedTransactions.count, 1, "Processed transactions count should be 2")
        XCTAssertEqual(processedTransactions[0].amount, 100, "Amount of the first transaction should be 100")
    }
}

