//
//  MovieCellViewModel.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation
import UIKit

final class MovieCellViewModel {
    
    private let movie:MovieModel
    let name: String
    let date:String
    let rating:String
    var image: UIImage?
    
    var didSetImage: ((UIImage) -> Void)? = { _ in }

    var onSelect: (MovieModel) -> Void = { _ in }
    
    init(movie:MovieModel) {
        self.movie = movie
        self.name = movie.original_title
        self.date = movie.releaseDate()
        self.rating = String(movie.vote_average)
        
       
    }
    
    func didSelect() {
        onSelect(movie)
    }
}

