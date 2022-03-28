//
//  SubredditListViewModel.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit

final class SubredditListViewModel {
    
    
    var coordinator:MainCoordinator!

    var onUpdate: () -> Void = {}

    let title = "Subreddits"
    
    var subs: [SubredditModel] = []
    var filteredSubs: [SubredditModel] = []
    
    var isSearching:Bool = false

    private(set) var cells: [SubredditCellViewModel] = []

    init(){
        
    }

    func viewDidLoad() {
        print("viewdidload")
        
        ApiManager.shared.fetchSubreddits { result in
            self.subs.append(contentsOf: result)
            
            self.reloadData()
        }
    }
    
    func beginSearch() {
        isSearching = true
        
        filteredSubs.forEach({ sub in
            let cellViewModel = SubredditCellViewModel(sub: sub)
            cellViewModel.onSelect = coordinator.onSelectSub
            cells.append(cellViewModel)
        })
        
        DispatchQueue.main.async {
            self.onUpdate()
        }
    }
    
    func endSearch() {
        
        
    }
    
    func filterCancelled() {
        isSearching = false
        
        reloadData()
    }
    
    func filterUsers(_ searchText: String) {
        
        filteredSubs.removeAll()
        
        ApiManager.shared.findSubreddits(searchString: searchText) { results in
            self.filteredSubs.append(contentsOf: results)
            
            self.reloadData()
        }
        
    }

    var isLoading = false
    func loadMore() {
        if isLoading == false && filteredSubs.isEmpty {
            
            isLoading = true
            
            let lastItem = self.subs.last
            guard let lastItemName = lastItem?.name else { return }
            
            DispatchQueue.global().async {
                ApiManager.shared.fetchSubreddits(lastID: lastItemName) { result in
                    
                    self.subs.append(contentsOf: result)
                    
                    self.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    private func reloadData() {
        cells.removeAll()
        
        let array = isSearching ? filteredSubs:subs
        array.forEach({ sub in
            let cellViewModel = SubredditCellViewModel(sub: sub)
            cellViewModel.onSelect = coordinator.onSelectSub
            cells.append(cellViewModel)
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
            
            if (filteredSubs.isEmpty) {
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

    func cell(for indexPath: IndexPath) -> SubredditCellViewModel {
        return cells[indexPath.row]
    }
    
    func didSelect(for indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        cell.didSelect()
    }

}
