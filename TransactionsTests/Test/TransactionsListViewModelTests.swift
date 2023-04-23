//
//  TransactionsListViewModelTests.swift
//  TransactionsTests
//
//  Created by Евгений Урбановский on 4/23/23.
//

import XCTest
import Combine
@testable import Transactions

final class TransactionsListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testGetTransactionsData_success() {
        let transactionsRepositoryMock = TransactionsRepositoryMock()
        let transactionsProcessorMock = TransactionsProcessorMock()

        let viewModel = TransactionsListViewModel(repository: transactionsRepositoryMock, transactionProcessor: transactionsProcessorMock)

        let expectation = XCTestExpectation(description: "Transactions updated")

        viewModel.$transactions
            .dropFirst()
            .sink { transactions in
                XCTAssertEqual(transactions.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}

