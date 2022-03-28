//
//  SubredditListTableViewController.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit
import Foundation

class SubredditListTableViewController: UITableViewController {
    
    var viewModel:SubredditListViewModel!
    
    let spinner = UIActivityIndicatorView(style: .large)
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        setupViews()
        
        viewModel.onUpdate = {
            self.tableView.reloadData()
            
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
        }
        
        viewModel.viewDidLoad()
    }
    
    func setupViews() {
        self.tableView.register(SubredditTableViewCell.self, forCellReuseIdentifier: "SubredditTableViewCell")
        
        self.title = viewModel?.title
        self.view.backgroundColor = UIColor.systemBackground
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = self.searchController;

        navigationItem.hidesSearchBarWhenScrolling = false
        
        SubredditPostsListTableViewController.setupSpinner(spinner: spinner, navigationController: self.navigationController)

    }
    

}


extension SubredditListTableViewController: UISearchControllerDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        tableView.tableFooterView = nil
        viewModel.beginSearch()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        viewModel.endSearch()
    }
}

extension SubredditListTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
        
        viewModel.filterUsers(searchText)
        
        SubredditPostsListTableViewController.setupSpinner(spinner: spinner, navigationController: self.navigationController)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterCancelled()
    }
}

extension SubredditListTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        viewModel.willDisplayCellAtIndexPath(indexPath, for: tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.didSelect(for: indexPath)
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cell(for: indexPath)
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SubredditTableViewCell", for: indexPath) as! SubredditTableViewCell
        cell.update(with: cellViewModel)
        return cell
            
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
}
