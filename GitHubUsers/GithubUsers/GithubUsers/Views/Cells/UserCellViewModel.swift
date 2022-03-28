//
//  UserCellViewModel.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit


final class UserCellViewModel {
    let username: String
    let details: String
    var image: UIImage?
    var didSetImage: ((UIImage) -> Void)? = { imageSet in }
    var cellPressed: (() -> Void)?
    
    init(username: String, details:String, imageUrlString: String, cellPressed: @escaping () -> Void) {
        self.username = username
        self.details = details
        
        self.cellPressed = cellPressed
        
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
}

