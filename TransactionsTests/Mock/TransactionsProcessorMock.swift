//
//  TransactionsProcessorMock.swift
//  TransactionsTests
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation
import Combine
@testable import Transactions

final class TransactionsProcessorMock: TransactionsProcessor {
    func processTransactions(_ transactions: [TransactionDTO]) -> [TransactionDTO] {
        transactions
    }
}

