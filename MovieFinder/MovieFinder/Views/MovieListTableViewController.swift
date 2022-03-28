//
//  MovieListTableViewController.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation

import UIKit
import Foundation

class MovieListTableViewController: UITableViewController {
    
    var viewModel:MovieListViewModel!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
//        setupViews()
        
        viewModel.onUpdate = {
            self.tableView.reloadData()

            self.stopLoading()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tableView.tableHeaderView = nil
        self.searchController.searchBar.removeFromSuperview()
    }
    
    func setupViews() {
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        self.title = viewModel?.title
        self.view.backgroundColor = UIColor.systemBackground
        
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
    
        self.tableView.tableHeaderView = self.searchController.searchBar;

    }
    

}

extension MovieListTableViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            startLoading()
            
            viewModel.filterUsers(searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count <= 0) {
            viewModel.filterCancelled()
        }
    }
}

extension MovieListTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        viewModel.didSelect(for: indexPath)

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellViewModel = viewModel.cell(for: indexPath)

        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.update(with: cellViewModel)
        return cell

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}
    
