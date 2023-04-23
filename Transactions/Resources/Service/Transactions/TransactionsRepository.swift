//
//  TransactionsRepository.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import BackbaseNetworking
import Combine

enum TransactionsRepositoryError: Error {
    case networkError(Error)
    case decodingError(Error)
    case unknown
}

protocol TransactionsRepository {
    func getTransactions(for user: UserType) -> AnyPublisher<[TransactionDTO], TransactionsRepositoryError>
}

struct TransactionsRepositoryImpl: TransactionsRepository {
    typealias Transactions = AnyPublisher<[TransactionDTO], TransactionsRepositoryError>
    
    private let networkService = TransactionsAPI()
    
    func getTransactions(
        for user: UserType = .withOnlyGroupedCompletedTransactions
    ) -> Transactions {
        networkService.getTransactions(userId: user.rawValue)
            .mapError { error -> TransactionsRepositoryError in
                .networkError(error)
            }
            .flatMap { data -> Transactions in
                self.decodeTransactions(from: data)
            }
            .eraseToAnyPublisher()
    }
    
    private func decodeTransactions(from data: Data) -> Transactions {
        Just(data)
            .decode(type: [TransactionResponse].self, decoder: JSONDecoder())
            .map { $0.map(TransactionDTO.init) }
            .mapError { error in
                error is DecodingError ? .decodingError(error as! DecodingError) : .unknown
            }
            .eraseToAnyPublisher()
    }
}
