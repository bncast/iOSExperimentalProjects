//
//  MovieDetailViewController.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel:MovieDetailViewModel! 
    
    override func viewDidLoad() {
        setupViews()
        
        viewModel.imageDidLoad = { posterImage in
            self.posterImageView.image = posterImage
            
            self.stopLoading()
        }
        
        viewModel.viewDidLoad()
    }
    
    func setupViews()
    {
        posterImageView.image = UIImage(named: "img_placeholder")
        
        posterImageView.backgroundColor = .systemGray6
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        descriptionLabel.text = viewModel.description
        
        startLoading()
        
    }
}
