//
//  MainCoordinator.swift
//  ScalableDemo
//
//  Created by Abdul Rahim on 14/03/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

//MARK::- MainCooordinator for navigation

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RepoViewModel(apiResource: NetworkManager())
        let view = ViewController(viewModel: viewModel)
        navigationController.pushViewController(view, animated: false)
    }
    
    
}
