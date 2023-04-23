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

extension TransactionDTO {
    init(with response: TransactionResponse) {
        description = Array(arrayLiteral: response.description)
        amount = Double(response.transactionAmountCurrency.amount) ?? 0.0
        currencyCode = CurrencyType(rawValue: response.transactionAmountCurrency.currencyCode) ?? .euro
        creditDebitIndicator = TransactionType(rawValue: response.creditDebitIndicator) ?? .credit
        creationTime = DateFormatParser.parseDate(from: response.creationTime)
        section = SectionType(rawValue: response.state) ?? .pending
    }
}
