//
//  ErrorState.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

struct ErrorState: TransactionsListState {
    private let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func configureUI(in viewController: TransactionsListViewController) {
        viewController.tableView.isHidden = true
        viewController.emptyLabel.isHidden = true
        viewController.errorLabel.isHidden = false
        viewController.errorLabel.text = error.localizedDescription
        viewController.loadingView.stopAnimating()
    }
}

