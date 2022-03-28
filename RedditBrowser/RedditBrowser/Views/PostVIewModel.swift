//
//  PostVIewModel.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import Foundation

final class PostViewModel {
    
    private let post: SubredditModel
    var url:URL?
    
    init(post: SubredditModel){
        self.post = post
        
        guard let urlString = post.permalink else { return }
        guard let myURL = URL(string: "https://www.reddit.com\(urlString)") else { return }
        url = myURL
    }
    
}
