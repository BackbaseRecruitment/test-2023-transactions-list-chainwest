//
//  LoadingState.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

struct LoadingState: TransactionsListState {
    func configureUI(in viewController: TransactionsListViewController) {
        viewController.tableView.isHidden = true
        viewController.emptyLabel.isHidden = true
        viewController.errorLabel.isHidden = true
        viewController.loadingView.startAnimating()
    }
}
