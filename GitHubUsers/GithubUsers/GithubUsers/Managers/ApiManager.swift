//
//  ApiManager.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation

class ApiManager {
    
    private let networkManger: NetworkManager
    static let shared = ApiManager()
    
    init() {
        self.networkManger = NetworkManager.shared
    }
    
    func fetchUsers(lastID: Int, completion: @escaping ([UserApiModel]) -> Void) {
        guard let url = URL(string: "https://api.github.com/users?since=\(lastID)") else { return }
        networkManger.request(url) { (result: Result<[UserApiModel], RequestError>)  in
            
            switch result {
                case .success(let successValue):
                    completion(successValue)
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
