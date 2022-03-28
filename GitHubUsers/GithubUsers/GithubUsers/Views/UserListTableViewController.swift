//
//  UserListTableViewController.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    var viewModel:UserListViewModel!
   
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        
        setupViews()
        
        viewModel.onUpdate = {
            self.tableView.reloadData()
            
        }
        
        viewModel?.viewDidLoad()
    }
    
    func setupViews() {
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        
        self.title = viewModel?.title
        self.view.backgroundColor = UIColor.systemBackground
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = self.searchController;

        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
}

extension UserListTableViewController: UISearchControllerDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        tableView.tableFooterView = nil
        viewModel.beginSearch()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        viewModel.endSearch()
    }
}

extension UserListTableViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterUsers(searchText)
    }
}

extension UserListTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        viewModel.willDisplayCellAtIndexPath(indexPath, for: tableView)
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let cellViewModel = viewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .user (let userCellViewModel):
            
            userCellViewModel.cellPressed!()
            
        case .userWithNotes:
            break
        case .userInverted:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .user (let userCellViewModel):
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            cell.update(with: userCellViewModel)
            return cell
        case .userWithNotes:
            return UITableViewCell()
        case .userInverted:
            return UITableViewCell()
        }
            
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}
