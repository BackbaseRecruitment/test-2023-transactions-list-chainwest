//
//  TransactionsRepositoryMock.swift
//  TransactionsTests
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation
import Combine
@testable import Transactions

final class TransactionsRepositoryMock: TransactionsRepository {
    func getTransactions(for user: UserType) -> AnyPublisher<[TransactionDTO], TransactionsRepositoryError> {
        let transactions = [
            TransactionDTO(description: ["Transaction 1"], amount: 100, currencyCode: .usd, creditDebitIndicator: .debit, creationTime: Date(), section: .pending),
            TransactionDTO(description: ["Transaction 2"], amount: 200, currencyCode: .usd, creditDebitIndicator: .credit, creationTime: Date(), section: .completed)
        ]

        return Just(transactions)
            .setFailureType(to: TransactionsRepositoryError.self)
            .eraseToAnyPublisher()
    }
}
