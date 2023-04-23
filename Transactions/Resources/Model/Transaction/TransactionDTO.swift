//
//  TransactionDTO.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

struct TransactionDTO: Hashable {
    let description: [String]
    let amount: Double
    let currencyCode: CurrencyType
    let creditDebitIndicator: TransactionType
    let creationTime: Date
    let section: SectionType
}
