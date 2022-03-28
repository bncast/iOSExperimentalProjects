//
//  UserModel.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import CoreData


public class UserCoreDataModel: NSManagedObject {
    
    @NSManaged var login: String
    @NSManaged var id: Int32
    @NSManaged var node_id: String
    @NSManaged var avatar_url: String
    @NSManaged var gravatar_id: String
    @NSManaged var url: String
    @NSManaged var html_url: String
    @NSManaged var followers_url: String
    @NSManaged var following_url: String
    @NSManaged var gists_url: String
    @NSManaged var starred_url: String
    @NSManaged var subscriptions_url: String
    @NSManaged var organizations_url: String
    @NSManaged var repos_url: String
    @NSManaged var events_url: String
    @NSManaged var received_events_url: String
    @NSManaged var type: String
    @NSManaged var site_admin: Bool
    
    func setData(fromApiModel apiModel: UserApiModel) {
        self.login = apiModel.login
        self.id = apiModel.id
        self.node_id = apiModel.node_id
        self.avatar_url = apiModel.avatar_url
        self.gravatar_id = apiModel.gravatar_id
        self.url = apiModel.url
        self.html_url = apiModel.url
        self.followers_url = apiModel.followers_url
        self.following_url = apiModel.following_url
        self.gists_url = apiModel.gists_url
        self.starred_url = apiModel.starred_url
        self.subscriptions_url = apiModel.subscriptions_url
        self.organizations_url = apiModel.organizations_url
        self.repos_url = apiModel.repos_url
        self.events_url = apiModel.events_url
        self.received_events_url = apiModel.received_events_url
        self.type = apiModel.type
        self.site_admin = apiModel.site_admin
    }
}


