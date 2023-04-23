//
//  TransactionsProcessor.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

protocol TransactionsProcessor {
    func processTransactions(_ transactions: [TransactionDTO]) -> [TransactionDTO]
}

struct TransactionsProcessorImpl: TransactionsProcessor {
    func processTransactions(_ transactions: [TransactionDTO]) -> [TransactionDTO] {
        mergeTransactions(transactions)
            .sorted { $0.date < $1.date }
    }
    
    private func mergeTransactions(_ transactions: [TransactionDTO]) -> [TransactionDTO] {
        let mergedTransactions = Dictionary(grouping: transactions) {
            "\($0.creditDebitIndicator.name)\($0.date)\($0.section.name)"
        }
        
        return mergedTransactions.map { (_, transactions) -> TransactionDTO in
            let description = transactions.flatMap { $0.description }
            let amount = transactions.reduce(0, { $0 + $1.amount })
            
            return TransactionDTO(
                description: description,
                amount: amount,
                currencyCode: transactions.first?.currencyCode ?? .euro,
                creditDebitIndicator: transactions.first?.creditDebitIndicator ?? .credit,
                creationTime: transactions.first?.creationTime ?? Date(),
                section: transactions.first?.section ?? .pending
            )
        }
    }
}
