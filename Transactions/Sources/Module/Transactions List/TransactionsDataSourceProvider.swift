//
//  TransactionsDataSourceProvider.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit

struct TransactionsDataSourceProvider {
    typealias DataSource = UITableViewDiffableDataSource<SectionType, TransactionDTO>
    
    static func makeDataSource(for tableView: UITableView) -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, transaction in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TransactionListViewCell.reuseIdentifier,
                for: indexPath
            ) as? TransactionListViewCell else {
                NSLog("Failed to initialize TransactionListViewCell.")
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.configure(with: transaction)
            return cell
        }
    }
    
    static func applySnapshot(
        to dataSource: DataSource,
        with list: [TransactionDTO],
        _ animated: Bool = true
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, TransactionDTO>()
        snapshot.appendSections([.pending, .completed])
        snapshot.appendItems(list.filter { $0.section == .pending }, toSection: .pending)
        snapshot.appendItems(list.filter { $0.section == .completed }, toSection: .completed)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}
