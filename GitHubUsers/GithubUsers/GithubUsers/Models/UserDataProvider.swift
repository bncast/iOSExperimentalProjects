//
//  UserDataProvider.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation

public class UserDataProvider {
    private var users:[UserApiModel]
    private let coreDataHandler:CoreDataHandler
    private let apiManager:ApiManager

    static let shared = UserDataProvider()
    init(){
        users = []
        coreDataHandler = CoreDataHandler.shared
        apiManager = ApiManager.shared
    }
    
    func fetchLocal() -> [UserApiModel]{
        users.removeAll()
        
        let coreDataUsers = self.coreDataHandler.fetch(UserCoreDataModel.self)
        
        coreDataUsers.forEach { user in
            users.append(UserApiModel(coreDataModel:user))
        }
        
        users.sort(by: { $0.id < $1.id })
        
        return users
    }
    
    func fetchRemote(completion: @escaping ([UserApiModel]) -> Void)  {
        var lastID = 0
        if let lastUser = users.last {
            lastID = Int(lastUser.id)
        }

        apiManager.fetchUsers(lastID: lastID) { users in
                                
            users.forEach { userApiModel in
                    
                if (self.coreDataHandler.checkIfItemExist(id: Int(userApiModel.id), UserCoreDataModel.self) == false) {
                    
                    let entry = self.coreDataHandler.add(UserCoreDataModel.self)
                    entry?.setData(fromApiModel: userApiModel)
                    
                    self.users.append(userApiModel)
                }
            }
        
            self.coreDataHandler.save()
            
            completion(self.users)
        }
        
        
    }
}
