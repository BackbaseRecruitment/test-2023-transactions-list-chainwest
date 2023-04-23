//
//  SectionType.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

enum SectionType: String, CaseIterable {
    case pending = "PENDING"
    case completed = "COMPLETED"
    
    var name: String {
        switch self {
        case .pending:
            return "Pending"
        case .completed:
            return "Completed"
        }
    }
}
