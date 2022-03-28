//
//  Coordinator.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }

    func start()
}
