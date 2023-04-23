//
//  TransactionResponse.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

struct TransactionResponse: Decodable {
    let id: String
    let description: String
    let typeGroup: String
    let type: String
    let category: String
    let transactionAmountCurrency: TransactionAmountCurrencyResponse
    let creditDebitIndicator: String
    let counterPartyName: String?
    let counterPartyAccountNumber: String?
    let counterPartyCity: String?
    let counterPartyAddress: String?
    let creationTime: String
    let state: String
}

extension TransactionResponse {
    struct TransactionAmountCurrencyResponse: Decodable {
        let amount: String
        let currencyCode: String
    }
}
