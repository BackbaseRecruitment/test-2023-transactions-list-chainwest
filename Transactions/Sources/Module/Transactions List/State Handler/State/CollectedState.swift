//
//  CollectedState.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

struct CollectedState: TransactionsListState {
    func configureUI(in viewController: TransactionsListViewController) {
        viewController.tableView.isHidden = false
        viewController.emptyLabel.isHidden = true
        viewController.errorLabel.isHidden = true
        viewController.loadingView.stopAnimating()
    }
}
