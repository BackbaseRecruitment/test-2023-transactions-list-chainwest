//
//  TransactionsListViewModel.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation
import Combine


final class TransactionsListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let repository: TransactionsRepository
    
    @Published private(set) var transactions = [TransactionDTO]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        repository: TransactionsRepository = TransactionsRepositoryImpl()
    ) {
        self.repository = repository
        getTransactionsData()
    }
    
    private func getTransactionsData() {
        handleTransactions()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: &$transactions)
    }
    
    private func handleTransactions() -> AnyPublisher<[TransactionDTO], TransactionsRepositoryError> {
        repository.getTransactions(for: .withGroupedPendingAndCompletedTransactions)
            .map(handleTransactions)
            .eraseToAnyPublisher()
    }
    
    private func handleTransactions(_ transactions: [TransactionDTO]) -> [TransactionDTO] {
        []
    }
}
