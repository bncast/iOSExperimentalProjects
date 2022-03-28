//
//  APIManager.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import Foundation

class ApiManager {
    
    private let networkManger: NetworkManager
    static let shared = ApiManager()
    
    init() {
        self.networkManger = NetworkManager.shared
    }
    
    func fetchPosts(fromSubreddit sub:String, lastID:String = "", completion: @escaping ([SubredditModel]) -> Void) {
        let lastComponent = lastID.isEmpty ? "": "&after=\(lastID)"
        let urlString = "https://www.reddit.com/\(sub).json?limit=30\(lastComponent)"
        guard let url = URL(string: urlString) else { return }
        networkManger.request(url) { (result: Result<SubredditResult, RequestError>)  in
            
            switch result {
                case .success(let successValue):
                    let data = successValue.data
                    let initial = data.children
                    let array = initial.map({$0.data})
                
                    completion(array)
                    break
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    completion([])
                    break
                // handle error
          }
        }
        
    }
    
    func fetchSubreddits(lastID:String = "", completion: @escaping ([SubredditModel]) -> Void) {
        let lastComponent = lastID.isEmpty ? "": "&after=\(lastID)"
        let urlString = "https://www.reddit.com/subreddits/popular.json?show=all&limit=30\(lastComponent)"
        guard let url = URL(string: urlString) else { return }
        networkManger.request(url) { (result: Result<SubredditResult, RequestError>)  in
            
            switch result {
                case .success(let successValue):
                    let data = successValue.data
                    let initial = data.children
                    let array = initial.map({$0.data})
                
                    completion(array)
                    break
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    completion([])
                    break
                // handle error
          }
        }
        
    }
    
    func findSubreddits(searchString:String, completion: @escaping ([SubredditModel]) -> Void) {
//        let lastComponent = lastID.isEmpty ? "": "&after=\(lastID)"
        let urlString = "https://www.reddit.com/subreddits/search.json?limit=30&q=\(searchString)"
        guard let url = URL(string: urlString) else { return }
        networkManger.request(url) { (result: Result<SubredditResult, RequestError>)  in
            
            switch result {
                case .success(let successValue):
                    let data = successValue.data
                    let initial = data.children
                    let array = initial.map({$0.data})
                
                    completion(array)
                    break
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    completion([])
                    break
                // handle error
          }
        }
        
    }
}
