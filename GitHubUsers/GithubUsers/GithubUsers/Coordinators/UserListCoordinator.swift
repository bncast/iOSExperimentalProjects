//
//  UserListCoordinator.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit

class UserListCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let userListViewController = UserListTableViewController()
        let userListViewModel = UserListViewModel()
        userListViewModel.coordinator = self
        userListViewController.viewModel = userListViewModel
        navigationController.pushViewController(userListViewController, animated: false)
    }
    
    func showProfile() {
        let userProfieViewController = UserProfileViewController.instantiate()
        let userProfileViewModel = UserProfileViewModel()
        userProfieViewController.viewModel = userProfileViewModel
        navigationController.pushViewController(userProfieViewController, animated: false)
    }
    
}
