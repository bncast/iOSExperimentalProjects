//
//  UserModel.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation


class UserApiModel: Codable {
    
    let login: String
    let id: Int32
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
    
    init(coreDataModel user: UserCoreDataModel){
        self.login = user.login
        self.id = user.id
        self.node_id = user.node_id
        self.avatar_url = user.avatar_url
        self.gravatar_id = user.gravatar_id
        self.url = user.url
        self.html_url = user.url
        self.followers_url = user.followers_url
        self.following_url = user.following_url
        self.gists_url = user.gists_url
        self.starred_url = user.starred_url
        self.subscriptions_url = user.subscriptions_url
        self.organizations_url = user.organizations_url
        self.repos_url = user.repos_url
        self.events_url = user.events_url
        self.received_events_url = user.received_events_url
        self.type = user.type
        self.site_admin = user.site_admin

    }
    
}
