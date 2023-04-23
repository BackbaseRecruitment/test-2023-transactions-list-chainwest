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
    private let transactionProcessor: TransactionsProcessor
    
    @Published private(set) var transactions = [TransactionDTO]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        repository: TransactionsRepository = TransactionsRepositoryImpl(),
        transactionProcessor: TransactionsProcessor = TransactionsProcessorImpl()
    ) {
        self.repository = repository
        self.transactionProcessor = transactionProcessor
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
            .map(transactionProcessor.processTransactions)
            .eraseToAnyPublisher()
    }
}
