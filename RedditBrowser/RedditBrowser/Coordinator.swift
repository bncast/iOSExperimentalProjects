//
//  Coordinator.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }

    func start()
}
