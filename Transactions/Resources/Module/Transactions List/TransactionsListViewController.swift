//
//  TransactionsListViewController.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit
import Combine
import BackbaseMDS


final class TransactionsListViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: TransactionsListViewModel
    
    // MARK: - Init
    
    init(viewModel: TransactionsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        setupUI()
    }
    
    // MARK: - Data binding
    
    private func bind(to viewModel: TransactionsListViewModel) {
        viewModel.$transactions
            .sink { [weak self] transactions in
                
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = NSLocalizedString("transactions.list.title", comment: "")
        view.backgroundColor = BackbaseUI.shared.colors.foundation
    }
}
