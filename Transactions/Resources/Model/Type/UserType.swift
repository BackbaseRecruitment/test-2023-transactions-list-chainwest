//
//  UserType.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

enum UserType: Int {
    case withoutAnyTransactions = 10000
    case withOnlySinglePendingTransactions = 10010
    case withOnlyGroupedPendingTransactions = 10011
    case withOnlySingleCompletedTransactions = 10012
    case withOnlyGroupedCompletedTransactions = 10013
    case withSinglePendingAndCompletedTransactions = 10014
    case withGroupedPendingAndCompletedTransactions = 10015
}
