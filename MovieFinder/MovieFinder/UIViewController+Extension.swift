//
//  UIViewController+Extension.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func startLoading() {
        guard let navigationview = navigationController!.view else { return }
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tag = 1999
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        navigationview.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: navigationview.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: navigationview.centerYAnchor)
        ])
    }
    
    func stopLoading() {
        guard let navigationview = navigationController!.view else { return }
        
        guard let spinner:UIActivityIndicatorView = navigationview.viewWithTag(1999) as? UIActivityIndicatorView else { return }
                
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    
}
