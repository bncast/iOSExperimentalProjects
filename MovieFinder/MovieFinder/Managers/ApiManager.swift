//
//  ApiManager.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import Foundation

class ApiManager {
    
    private let API_KEY = "78ea22df5ab22e4aaf4ccda8d334243d"
    private let BASE_URL = "https://api.themoviedb.org/3"
    
    public private(set) var imageConfig: Config?
    
    private let networkManger: NetworkManager
    static let shared = ApiManager()
    
    init() {
        self.networkManger = NetworkManager.shared
        
        config {
            print("config loaded")
        }
    }
    
    func findMovie(searchString:String, page:Int = 1, completion: @escaping ([MovieModel]) -> Void) {
        
        let originalString = "\(BASE_URL)/search/movie?api_key=\(API_KEY)&language=en-US&query=\(searchString)&page=\(page)&include_adult=false"

        guard let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        guard let url = URL(string: urlString) else { return }
        networkManger.request(url) { (result: Result<MovieParentModel, RequestError>)  in

            switch result {
                case .success(let successValue):
                    guard let array = successValue.results else
                    {
                        completion([])
                        return
                        
                    }
                    completion(array)
                    break
                case .failure(let error):

                    print(error.localizedDescription)
                    completion([])
                    break
          }
        }
    }
    
    func config(completion: @escaping () -> Void) {
        let urlString = "\(BASE_URL)/configuration?api_key=\(API_KEY)"

        guard let url = URL(string: urlString) else { return }
        networkManger.request(url) { (result: Result<ConfigParent, RequestError>)  in

            switch result {
                case .success(let successValue):
                    self.imageConfig = successValue.images
                
                    completion()
                    break
                case .failure(let error):

                    print(error.localizedDescription)
                    completion()
                    break
                // handle error
          }
        }
    }
}

struct Config:Codable {
    let base_url:String
    let secure_base_url:String
    let backdrop_sizes:[String]
    let logo_sizes:[String]
    let poster_sizes:[String]
    let profile_sizes:[String]
    let still_sizes:[String]
}

struct ConfigParent:Codable {
    let images: Config
}
