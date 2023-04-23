//
//  CurrencyType.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

enum CurrencyType: String {
    case euro = "EUR"
    case usd = "USD"
    
    var sign: String {
        switch self {
        case .euro:
            return "€"
        case .usd:
            return "$"
        }
    }
}
