//
//  Storyboarded.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
