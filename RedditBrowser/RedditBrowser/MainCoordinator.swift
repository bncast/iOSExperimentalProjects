//
//  MainCoordinator.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let listViewController = SubredditListTableViewController()
        let viewModel = SubredditListViewModel()
        viewModel.coordinator = self
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: false)
    }
    
    func onSelectSub(_ sub: SubredditModel) {
        let listViewController = SubredditPostsListTableViewController()
        let viewModel = SubredditPostsListViewModel(sub: sub)
        viewModel.coordinator = self
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: false)
    }
    
    func onSelectPost(_ post:SubredditModel) {
        let postViewController = PostViewController.instantiate()
        let viewModel = PostViewModel(post: post)
        postViewController.viewModel = viewModel

        navigationController.pushViewController(postViewController, animated: false)
    }
    
}
