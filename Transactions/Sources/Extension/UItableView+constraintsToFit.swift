//
//  UItableView+constraintsToFit.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit
import BackbaseMDS

extension UITableView {
    func constraintsToFit(in parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: BackbaseUI.shared.spacers.md),
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: BackbaseUI.shared.spacers.md),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -BackbaseUI.shared.spacers.md),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -BackbaseUI.shared.spacers.md)
        ])
    }
}
