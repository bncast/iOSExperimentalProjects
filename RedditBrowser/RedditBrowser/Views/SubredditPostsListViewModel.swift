//
//  SubredditPostsListViewModel.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//
import Foundation
import UIKit

final class SubredditPostsListViewModel {
    
    var coordinator:MainCoordinator!
    
    let sub:SubredditModel

    var onUpdate: () -> Void = {}

    let title:String
    
    var posts: [SubredditModel] = []
    

    private(set) var cells: [SubredditPostCellViewModel] = []

    init(sub: SubredditModel){
        self.sub = sub
        
        title = sub.display_name_prefixed ?? ""
    }

    func viewDidLoad() {
        print("viewdidload")
        
        ApiManager.shared.fetchPosts(fromSubreddit: title) { result in
            
            self.posts.append(contentsOf: result)
            
            self.reloadData()

        }
     }

    var isLoading = false
    func loadMore() {
        if isLoading == false {
            
            isLoading = true
            
            let lastItem = self.posts.last
            guard let lastItemName = lastItem?.name else { return }
            
            DispatchQueue.global().async {
                ApiManager.shared.fetchPosts(fromSubreddit: self.title, lastID: lastItemName) { result in
                    
                        self.posts.append(contentsOf: result)
    
                        self.reloadData()
                        self.isLoading = false
                }
            }
        }
    }
    
    private func reloadData() {
        cells.removeAll()
    
        posts.forEach({ post in
            
            let cellViewModel = SubredditPostCellViewModel(post: post)
            cellViewModel.onSelect = coordinator.onSelectPost
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
            
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            
            tableView.tableFooterView = spinner
            
            loadMore();
        }
    }

    func numberOfRows() -> Int {
        return cells.count
    }

    func cell(for indexPath: IndexPath) -> SubredditPostCellViewModel {
        return cells[indexPath.row]
    }
    
    func didSelect(for indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        cell.didSelect()
    }
}
