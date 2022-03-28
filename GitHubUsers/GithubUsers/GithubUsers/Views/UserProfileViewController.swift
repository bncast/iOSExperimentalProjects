//
//  UserProfileViewController.swift
//  GithubUsers
//
//  Created by Nino on 3/28/22.
//

import UIKit

class UserProfileViewController: UIViewController, Storyboarded {
    var viewModel:UserProfileViewModel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        setupViews()
    }
    
    func setupViews() {
        self.title = viewModel?.title
        self.view.backgroundColor = UIColor.systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        avatarImageView.backgroundColor = .systemGray5
        followersLabel.text = "Followers: 0"
        followingLabel.text = "Following: 0"
        
        infoStackView.backgroundColor = .systemGray6
        notesTextView.backgroundColor = .systemGray6
        
        saveButton.setTitle("Save", for: .normal)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    
    }
    
    
}
