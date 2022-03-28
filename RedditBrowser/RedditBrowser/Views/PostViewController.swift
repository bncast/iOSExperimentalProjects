//
//  PostViewController.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import Foundation
import UIKit
import WebKit

class PostViewController: UIViewController, Storyboarded, WKNavigationDelegate {
    
    var viewModel: PostViewModel!
    
    @IBOutlet weak var webView: WKWebView!
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = viewModel.url else { return }
        let myRequest = URLRequest(url: url)
        
        webView.navigationDelegate = self
        
        webView.load(myRequest)
        
        SubredditPostsListTableViewController.setupSpinner(spinner: spinner, navigationController: self.navigationController)
    
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
