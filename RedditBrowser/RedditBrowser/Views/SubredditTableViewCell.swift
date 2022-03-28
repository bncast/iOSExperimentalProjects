//
//  SubredditTableViewCell.swift
//  RedditBrowser
//
//  Created by Nino on 3/28/22.
//

import UIKit

final class SubredditTableViewCell: UITableViewCell {
    
    let usernameLabel = UILabel()
    
    let avatarImageView = UIImageView()
    
    let horizontalStack = UIStackView()
    
    let padding:CGFloat = 16.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHeirarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: SubredditCellViewModel) {
        usernameLabel.text = viewModel.name
        avatarImageView.image = viewModel.image
        
        viewModel.didSetImage = { downloadedImage in
            self.avatarImageView.image = downloadedImage
        }
    }
    
    func setupViews() {
        horizontalStack.axis = .horizontal
        usernameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        
      
        horizontalStack.spacing = padding
        
        avatarImageView.backgroundColor = UIColor.systemGray6
        
        [avatarImageView, horizontalStack, usernameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHeirarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(avatarImageView)
        
        horizontalStack.addArrangedSubview(usernameLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 30),
            avatarImageView.widthAnchor.constraint(equalToConstant: 30),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            horizontalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            contentView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: padding)
        ])
    }
    
}
