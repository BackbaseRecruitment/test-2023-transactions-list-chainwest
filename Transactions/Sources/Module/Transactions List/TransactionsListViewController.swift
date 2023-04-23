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
    
    let tableView = UITableView()
    let emptyLabel = UILabel()
    let errorLabel = UILabel()
    let loadingView = UIActivityIndicatorView(style: .large)
    
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
        
        viewModel.$state
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        title = NSLocalizedString("transactions.list.title", comment: "")
        view.backgroundColor = BackbaseUI.shared.colors.foundation
        setupTableView()
        setupEmptyLabel()
        setupErrorLabel()
        setupLoadingView()
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
    
    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = NSLocalizedString("transactions.list.empty", comment: "")
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.font = BackbaseUI.shared.fonts.preferredFont(.body, .semibold)
        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = BackbaseUI.shared.fonts.preferredFont(.body, .semibold)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - TransactionsListStateHandler

extension TransactionsListViewController: TransactionListStateHandler {
    func handleState(_ state: TransactionsListState) {
        state.configureUI(in: self)
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
