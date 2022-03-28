//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Nino on 3/21/22.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    let usernameLabel = UILabel()
    let detailsLabel = UILabel()
    
    let avatarImageView = UIImageView()
    
    let verticalStack = UIStackView()
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
    
    func update(with viewModel: UserCellViewModel) {
        usernameLabel.text = viewModel.username
        detailsLabel.text = viewModel.details
        avatarImageView.image = viewModel.image
        
        viewModel.didSetImage = { downloadedImage in
            self.avatarImageView.image = downloadedImage
        }
    }
    
    func setupViews() {
        verticalStack.axis = .vertical
        horizontalStack.axis = .horizontal
        usernameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        
        detailsLabel.numberOfLines = 0
        detailsLabel.lineBreakMode = .byWordWrapping
        
        detailsLabel.font = .systemFont(ofSize: 22)
        horizontalStack.spacing = padding
        
        avatarImageView.backgroundColor = UIColor.systemGray6
        
        [avatarImageView, horizontalStack, verticalStack, usernameLabel, detailsLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHeirarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(avatarImageView)
        horizontalStack.addArrangedSubview(verticalStack)
        
        verticalStack.addArrangedSubview(usernameLabel)
        verticalStack.addArrangedSubview(detailsLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            horizontalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            contentView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: padding)
        ])
    }
    
}
