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
    
    // MARK: - Properties
    
    private lazy var dataSource = TransactionsDataSourceProvider.makeDataSource(for: tableView)
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: TransactionsListViewModel
    
    // MARK: - UI
    
    private let tableView = UITableView()
    
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
                guard let self else { return }
                TransactionsDataSourceProvider.applySnapshot(
                    to: self.dataSource,
                    with: transactions
                )
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = NSLocalizedString("transactions.list.title", comment: "")
        view.backgroundColor = BackbaseUI.shared.colors.foundation
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(
            TransactionListViewCell.self,
            forCellReuseIdentifier: TransactionListViewCell.reuseIdentifier
        )
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.constraintsToFit(in: view)
    }
}

// MARK: - UITableViewDelegate

extension TransactionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = SectionType.allCases[section]
        let label = UILabel()
        label.text = type.name
        label.font = BackbaseUI.shared.fonts.preferredFont(.title2, .semibold)
        return label
    }
}
