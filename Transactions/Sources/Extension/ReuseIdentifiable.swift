//
//  ReuseIdentifiable.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
