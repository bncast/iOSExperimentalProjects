//
//  SubredditPostsListTableViewController.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit

class SubredditPostsListTableViewController: UITableViewController {
    
    var viewModel:SubredditPostsListViewModel!
    
    var spinner = UIActivityIndicatorView(style: .large)
    
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
        
        self.tableView.register(SubredditPostTableViewCell.self, forCellReuseIdentifier: "SubredditPostTableViewCell")
        
        self.title = viewModel?.title
        self.view.backgroundColor = UIColor.systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        SubredditPostsListTableViewController.setupSpinner(spinner: spinner, navigationController: self.navigationController)
    }
    
   
    
    static func setupSpinner(spinner: UIActivityIndicatorView, navigationController: UINavigationController?) {
        guard let navigationview = navigationController!.view else { return }
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        navigationview.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: navigationview.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: navigationview.centerYAnchor)
        ])
    }
}

extension SubredditPostsListTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        viewModel.willDisplayCellAtIndexPath(indexPath, for: tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewModel.didSelect(for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cell(for: indexPath)
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SubredditPostTableViewCell", for: indexPath) as! SubredditPostTableViewCell
        
        cell.update(with: cellViewModel)
        
        return cell
            
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}
