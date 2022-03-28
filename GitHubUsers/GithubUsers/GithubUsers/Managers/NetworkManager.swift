//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation
import UIKit

class NetworkManager {
        
    static let shared = NetworkManager()
    
    private var imagesCache = NSCache<NSString, UIImage>()
    
    init() {  }
    
    func request<T:Codable>(_ url: URL, completion: @escaping (Result<T, RequestError>) -> Void) {
        
        let queue = DispatchQueue(label: "NetworkQueue")
        
        queue.async {
            let request = URLRequest(url: url)
            
            let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(.clientError))
                    return
                }

                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.serverError))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }

                guard let decodedData: T = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.dataDecodingError))
                    return
                }

                completion(.success(decodedData))
            }

            urlTask.resume()
        }
        
    }
    
    func download(imageURL: URL, completion: @escaping  (Result<UIImage, RequestError>) -> Void) {
        
        if let imageData = imagesCache.object(forKey: (imageURL.absoluteString as NSString)) {
            completion(.success(imageData))
            return
        }
        
        let queue = DispatchQueue(label: "NetworkQueue")
        
        queue.async {
            let request = URLRequest(url: imageURL)
            
            let urlTask = URLSession.shared.downloadTask(with: request) { localUrl, response, error in
                guard error == nil else {
                    completion(.failure(.clientError))
                    return
                }

                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.serverError))
                    return
                }

                guard let localUrl = localUrl else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let data = try Data(contentsOf: localUrl)
                    if let image = UIImage(data: data) {
                        self.imagesCache.setObject(image, forKey: (imageURL.absoluteString as NSString))
                        completion(.success(image))
                    } else {
                        completion(.failure(.dataDecodingError))
                    }
                } catch {
                    completion(.failure(.dataDecodingError))
                }

            }
            urlTask.resume()
        }
    }
    
}
