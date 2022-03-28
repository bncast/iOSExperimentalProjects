//
//  MovieDetailViewModel.swift
//  MovieFinder
//
//  Created by Nino on 3/29/22.
//

import Foundation
import UIKit

final class MovieDetailViewModel {
    
    var coordinator:MainCoordinator!
    
    private let movie:MovieModel
    
    let title:String
    let date:String
    let description:String
    
    var imageDidLoad:((UIImage) -> Void) = { _  in }
    
    init(movie: MovieModel) {
        self.movie = movie
        
        title = movie.original_title
        description = movie.overview
        date = movie.releaseDate()
    }
    
    func viewDidLoad() {
        
        ApiManager.shared.config {
            guard let imageConfig = ApiManager.shared.imageConfig else {return}
            guard let posterSize:String = imageConfig.poster_sizes.last else {return}
            guard let posterPath = self.movie.poster_path else {return}
            let imgUrlString = String(format: "%@%@%@", imageConfig.secure_base_url, posterSize, posterPath)
            guard let imageUrl = URL(string: imgUrlString) else { return }
           
            
            NetworkManager.shared.download(imageURL: imageUrl) { result  in
                
                switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.imageDidLoad(data)
                        }
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                        break
              }
            }
        }
    }


}
