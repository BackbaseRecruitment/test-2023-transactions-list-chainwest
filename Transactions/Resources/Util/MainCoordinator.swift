//
//  MainCoordinator.swift
//  Transactions
//
//  Created by Евгений Урбановский on 4/23/23.
//

import UIKit
import BackbaseMDS

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private var window: UIWindow?
    private var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(
        window: UIWindow?,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController
        setupNavigationController()
    }
    
    // MARK: - Internal methods
    
    func start() {
        guard let window else { return }
        
        let coordinator = TransactionsListCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        coordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.backgroundColor = BackbaseUI.shared.colors.primary
        navigationController.navigationBar.barTintColor = BackbaseUI.shared.colors.primary
        navigationController.navigationBar.isTranslucent = true
    }
}
