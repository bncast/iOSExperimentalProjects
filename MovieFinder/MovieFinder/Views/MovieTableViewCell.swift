//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Nino on 3/28/22.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let ratingLabel = UILabel()
    let horizontalStack = UIStackView()
    let verticalStack = UIStackView()
    let padding:CGFloat = 8.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHeirarchy()
        setupLayout()
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: MovieCellViewModel) {
        titleLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        ratingLabel.text = viewModel.rating
    }
    
    func setupViews() {
        verticalStack.axis = .vertical
        horizontalStack.axis = .horizontal
        
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        ratingLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        horizontalStack.spacing = padding * 2
        
        [verticalStack, horizontalStack, titleLabel, dateLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHeirarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(verticalStack)
        
        horizontalStack.addArrangedSubview(ratingLabel)
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(dateLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStack.heightAnchor.constraint(equalToConstant: 65),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            ratingLabel.widthAnchor.constraint(equalToConstant: 25),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            horizontalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding*2),
            contentView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor, constant: padding),
            contentView.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: padding)
        ])
        
        titleLabel.sizeToFit()
    }
    
}
