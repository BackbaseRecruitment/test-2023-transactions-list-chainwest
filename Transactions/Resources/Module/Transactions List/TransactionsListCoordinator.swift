//
//  TransactionsListCoordinator.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit

final class TransactionsListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController

    // MARK: - Init
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Internal methods
    
    func start() {
        let viewModel = TransactionsListViewModel()
        let vc = TransactionsListViewController(viewModel: viewModel)
        navigationController.setViewControllers([vc], animated: false)
    }
}
