//
//  MovieModel.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation

class MovieModel:Codable {
    
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title:String
    let overview:String
    let popularity:Double
    let poster_path:String?
    private var release_date:String?
    let title:String
    let video:Bool
    let vote_average:Double
    let vote_count:Int
    
    func releaseDate() -> String {
        guard let currentDate = self.release_date else {return ""}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:currentDate) else { return ""}
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)    }
}

class MovieParentModel:Codable {
    let page: Int
    let results: [MovieModel]?
}
