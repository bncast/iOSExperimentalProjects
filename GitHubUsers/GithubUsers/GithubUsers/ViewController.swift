//
//  ViewController.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import UIKit

class ViewController: UIViewController, NetworkConnectivityDelegate {

    let userDataProvider = UserDataProvider.shared
    var users:[UserApiModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NetworkMonitor.shared.delegate = self
        
        users = userDataProvider.fetchLocal()
        
        if users.count > 0 {
            print(users.map { "\($0.login)  \($0.id)" })
        }
        
        userDataProvider.fetchRemote { users in
            self.users = users
            
            print(users.map { "\($0.login)  \($0.id)" })
        }
        
    }
    
    func connectivityDidChange(isConnected: Bool) {
        print("Connected \(isConnected)")
    }
    

}

