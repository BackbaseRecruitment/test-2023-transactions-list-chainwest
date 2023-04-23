//
//  AppDelegate.swift
//  Transactions
//
//  Created by Backbase R&D B.V on 29/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var mainCoordinator: Coordinator?
    private let navigationController = UINavigationController()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = createWindow(with: navigationController)
        mainCoordinator = createMainCoordinator(window: window, navigationController: navigationController)
        mainCoordinator?.start()
        return true
    }
}

private extension AppDelegate {
    func createWindow(with navigationController: UINavigationController) -> UIWindow? {
        let windowFrame = UIScreen.main.bounds
        let newWindow = UIWindow(frame: windowFrame)
        newWindow.rootViewController = navigationController
        newWindow.makeKeyAndVisible()
        return newWindow
    }
    
    func createMainCoordinator(
        window: UIWindow?,
        navigationController: UINavigationController
    ) -> Coordinator {
        MainCoordinator(window: window, navigationController: navigationController)
    }
}

