//
//  SubredditPostCellViewModel.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//
import UIKit

final class SubredditPostCellViewModel {
    private let post:SubredditModel
    let name: String
    var image: UIImage?
    
    var didSetImage: ((UIImage) -> Void)? = { _ in }

    var onSelect: (SubredditModel) -> Void = { _ in }
    
    init(post:SubredditModel) {
        self.post = post
        self.name = post.title ?? ""
        
        if let img = image {
            didSetImage?(img)
            return
        }
        
        var imageUrlString:String!
        
        if let img = post.thumbnail, img.isEmpty == false { imageUrlString = img }
        else { imageUrlString = "https://external-preview.redd.it/iDdntscPf-nfWKqzHRGFmhVxZm4hZgaKe5oyFws-yzA.png?auto=webp&s=38648ef0dc2c3fce76d5e1d8639234d8da0152b2" }
        
      
        guard let imageUrl = URL(string: imageUrlString) else { return }
       
        NetworkManager.shared.download(imageURL: imageUrl) { result  in
            
            switch result {
                case .success(let data):
                    self.image = data
                    DispatchQueue.main.async {
                        self.didSetImage?(data)
                    }
                    break
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    
                    break
                // handle error
          }

        }
    }
    
    func didSelect() {
        onSelect(post)
    }
}

