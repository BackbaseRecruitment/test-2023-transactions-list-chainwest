//
//  TransactionsListCellView.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit
import BackbaseMDS

final class TransactionListViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let incomeOutcomeImageView = UIImageView()
    private let totalTransactionsLabel = UILabel()
    private let availableTransactionsLabel = UILabel()
    private let dateLabel = UILabel()
    private let dividerView = UIView()
    private let amountLabel = UILabel()
    private let wrap = UIView()
    private let contentShadowLayer = CAShapeLayer()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: contentView.bounds.insetBy(dx: 10, dy: 10), cornerRadius: BackbaseUI.shared.shadows.medium.radius)
        contentShadowLayer.path = path.cgPath
        contentShadowLayer.shadowPath = contentShadowLayer.path
    }
    
    // MARK: - Internal methods
    
    func configure(with dto: TransactionDTO) {
        dateLabel.text = dto.date
        incomeOutcomeImageView.image = dto.transactionTypeImage.withRenderingMode(.alwaysTemplate)
        totalTransactionsLabel.text = "\(dto.description.count) \(dto.creditDebitIndicator.name)"
        availableTransactionsLabel.text = dto.description.joined(separator: "\n")
        amountLabel.text = dto.totalCost
        amountLabel.textColor = dto.totalCostTextColor
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        setupShadow()
        setupShapeLayer()
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        setupWrapView()
        
        [
            incomeOutcomeImageView,
            totalTransactionsLabel,
            availableTransactionsLabel,
            dateLabel,
            dividerView,
            amountLabel
        ].forEach { view in
            wrap.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupIncomeOutcomeImageView()
        setupTotalTransactionsLabel()
        setupDateLabel()
        setupAvailableTransactionsLabel()
        setupDividerView()
        setupAmountLabel()
    }
    
    private func setupWrapView() {
        wrap.backgroundColor = BackbaseUI.shared.colors.onPrimary
        wrap.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrap)
        
        NSLayoutConstraint.activate([
            wrap.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrap.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrap.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            wrap.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
    }
    
    private func setupIncomeOutcomeImageView() {
        incomeOutcomeImageView.tintColor = BackbaseUI.shared.colors.primary
        incomeOutcomeImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            incomeOutcomeImageView.heightAnchor.constraint(equalToConstant: 17),
            incomeOutcomeImageView.widthAnchor.constraint(equalToConstant: 17),
            incomeOutcomeImageView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: BackbaseUI.shared.spacers.md),
            incomeOutcomeImageView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: BackbaseUI.shared.spacers.md)
        ])
    }
    
    private func setupTotalTransactionsLabel() {
        totalTransactionsLabel.numberOfLines = 1
        totalTransactionsLabel.font = BackbaseUI.shared.fonts.preferredFont(.footnote, .semibold)
        NSLayoutConstraint.activate([
            totalTransactionsLabel.leadingAnchor.constraint(equalTo: incomeOutcomeImageView.trailingAnchor, constant: 5),
            totalTransactionsLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: BackbaseUI.shared.spacers.md)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.font = BackbaseUI.shared.fonts.preferredFont(.footnote, .semibold)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: totalTransactionsLabel.trailingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: BackbaseUI.shared.spacers.md),
            dateLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -BackbaseUI.shared.spacers.md)
        ])
    }
    
    private func setupAvailableTransactionsLabel() {
        availableTransactionsLabel.textColor = BackbaseUI.shared.colors.textSupport
        availableTransactionsLabel.font = BackbaseUI.shared.fonts.preferredFont(.footnote, .regular)
        availableTransactionsLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            availableTransactionsLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: BackbaseUI.shared.spacers.md),
            availableTransactionsLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -BackbaseUI.shared.spacers.md),
            availableTransactionsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: BackbaseUI.shared.spacers.sm)
        ])
    }
    
    private func setupDividerView() {
        dividerView.backgroundColor = BackbaseUI.shared.colors.separator
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: BackbaseUI.shared.spacers.md),
            dividerView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -BackbaseUI.shared.spacers.md),
            dividerView.topAnchor.constraint(equalTo: availableTransactionsLabel.bottomAnchor, constant: BackbaseUI.shared.spacers.sm),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupAmountLabel() {
        amountLabel.numberOfLines = 1
        amountLabel.font = BackbaseUI.shared.fonts.preferredFont(.headline, .semibold)
        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -BackbaseUI.shared.spacers.md),
            amountLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: BackbaseUI.shared.spacers.sm),
            amountLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -BackbaseUI.shared.spacers.md)
        ])
    }
    
    private func setupShapeLayer() {
        wrap.layer.cornerRadius = BackbaseUI.shared.radiuses.large
        wrap.layer.masksToBounds = true
    }
    
    private func setupShadow() {
        contentView.layer.insertSublayer(contentShadowLayer, at: 0)
        contentShadowLayer.shadowColor = BackbaseUI.shared.shadows.medium.color.cgColor
        contentShadowLayer.shadowOpacity = BackbaseUI.shared.shadows.medium.opacity
        contentShadowLayer.shadowOffset = BackbaseUI.shared.shadows.medium.offset
        contentShadowLayer.shadowRadius = BackbaseUI.shared.shadows.medium.radius
    }
}

