//
//  Date+toString.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"

        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
