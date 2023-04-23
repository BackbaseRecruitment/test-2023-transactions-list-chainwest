//
//  TransactionType.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

enum TransactionType: String {
    case credit = "CRDT"
    case debit = "DBIT"
    
    var name: String {
        switch self {
        case .credit:
            return "Credit"
        case .debit:
            return "Debit"
        }
    }
    
    var operationSign: String {
        switch self {
        case .credit:
            return "+"
        case .debit:
            return "-"
        }
    }
}

