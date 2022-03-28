//
//  MainCoordinator.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import UIKit



private let API_KEY = "78ea22df5ab22e4aaf4ccda8d334243d"

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBlue
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = navBarAppearance
        UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = navBarAppearance
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    func start() {
        let listViewController = MovieListTableViewController()
        let viewModel = MovieListViewModel()
        viewModel.coordinator = self
        listViewController.viewModel = viewModel
        navigationController.pushViewController(listViewController, animated: false)
    }
    
    
    func onSelect(_ movie: MovieModel){
        let detailViewController = MovieDetailViewController.instantiate()
        let viewModel = MovieDetailViewModel(movie: movie)
        viewModel.coordinator = self
        detailViewController.viewModel = viewModel
        navigationController.pushViewController(detailViewController, animated: false)
    }
}
