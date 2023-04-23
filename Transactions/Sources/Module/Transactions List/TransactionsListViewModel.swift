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
    
    @Published private(set) var state: TransactionsListState = LoadingState()
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
        state = LoadingState()
        handleTransactions()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.state = ErrorState(error: error)
                case .finished:
                    self.state = self.transactions.isEmpty ? EmptyState() : CollectedState()
                }
            }, receiveValue: { [weak self] transactions in
                self?.transactions = transactions
            })
            .store(in: &cancellables)
    }
    
    private func handleTransactions() -> AnyPublisher<[TransactionDTO], TransactionsRepositoryError> {
        repository.getTransactions(for: .withGroupedPendingAndCompletedTransactions)
            .map(transactionProcessor.processTransactions)
            .eraseToAnyPublisher()
    }
}
