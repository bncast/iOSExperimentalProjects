//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit
import Foundation

final class UserListViewModel {
    
    var coordinator:UserListCoordinator!
    
    var onUpdate: () -> Void = {}
    
    let title = "Users"
    var users: [UserApiModel]!
    var filteredUsers: [UserApiModel] = []
    var userDataProvider = UserDataProvider.shared
    
    enum Cell {
        case user(UserCellViewModel)
        case userWithNotes
        case userInverted
    }
    
    private(set) var cells: [Cell] = []
    
    init(){
        users = userDataProvider.fetchLocal()
    }
    
    func viewDidLoad() {
        print("viewdidload")
        
        reloadData(users)
        
        if (users.isEmpty) {
            loadMore()
        }
    }
    
    func beginSearch() {
        filteredUsers = users
    }
    
    func endSearch() {
        filteredUsers = []
        reloadData(users)
    }
    
    func filterUsers(_ searchText: String) {
        
        filteredUsers.removeAll()
        
        if searchText.count == 0 {
            filteredUsers = users
        } else {
            filteredUsers = users.filter( { (user: UserApiModel) -> Bool in
                let username = user.login.lowercased()
                let searchValue = searchText.lowercased()
                return username == searchValue || username.contains(searchValue)
            })
        }
        print(filteredUsers)
        
        reloadData(filteredUsers)
    }
    
    var isLoading = false
    func loadMore() {
        if isLoading == false && filteredUsers.isEmpty {
            
            isLoading = true
            DispatchQueue.global().async {
                self.userDataProvider.fetchRemote { users in
                    self.users = users
                    self.reloadData(self.users)
                    
                    self.isLoading = false
                }
            }
        }
    }
    
    private func reloadData(_ users: [UserApiModel]) {
        cells.removeAll()
        
        users.forEach({ userModel in
            cells.append(.user(UserCellViewModel(username: userModel.login, details: userModel.url, imageUrlString: userModel.avatar_url, cellPressed: {
                self.coordinator.showProfile()
                
            })))
        })
        
        DispatchQueue.main.async {
            self.onUpdate()
        }
        
    }
    
    func willDisplayCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isLastRow = indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex
        
        if (isLastRow) {
            
            if (filteredUsers.isEmpty) {
                let spinner = UIActivityIndicatorView(style: .large)
                spinner.startAnimating()
                
                tableView.tableFooterView = spinner
            }
        
            loadMore();
        }
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
