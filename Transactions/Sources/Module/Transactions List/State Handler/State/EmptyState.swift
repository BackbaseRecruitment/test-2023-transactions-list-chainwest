//
//  EmptyState.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

struct EmptyState: TransactionsListState {
    func configureUI(in viewController: TransactionsListViewController) {
        viewController.tableView.isHidden = true
        viewController.emptyLabel.isHidden = false
        viewController.errorLabel.isHidden = true
        viewController.loadingView.stopAnimating()
    }
}

