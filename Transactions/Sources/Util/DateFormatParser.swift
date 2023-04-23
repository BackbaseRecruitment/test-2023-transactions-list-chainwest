//
//  DateFormatParser.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import Foundation

struct DateFormatParser {
    static func parseDate(from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let date = dateFormatter.date(from: string) else {
            NSLog("Couldn't parse date from string.")
            return Date()
        }
        
        return date
    }
}
