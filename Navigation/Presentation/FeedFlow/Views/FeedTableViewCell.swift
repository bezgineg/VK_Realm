//
//  FeedTableViewCell.swift
//  Navigation
//
//  Created by Евгений on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var currentIndex = 0
    
    private let authorName: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        label.numberOfLines = 2
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.toAutoLayout()
        imageView.backgroundColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.createColor(lightMode: Colors.systemGray, darkMode: Colors.gray)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.backgroundColor = UIColor.white.withAlphaComponent(0)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(with post: Post, index: Int) {
        authorName.text = post.author
        descriptionLabel.text = post.description
        likesLabel.text = "\(localizeLikes(count: UInt(post.likes))): \(post.likes)"
        viewsLabel.text = "\(localizeViews(count: UInt(post.view))): \(post.view)"
        postImageView.image = post.image
        currentIndex = index
    }
    
    // MARK: - Private Methods
    
    @objc private func addButtonTapped() {
        print(currentIndex)
    }
    
    private func localizeViews(count: UInt) -> String {
        let formatString: String = NSLocalizedString("views count", comment: "views count title")
        let resultString: String = String.localizedStringWithFormat(formatString, count)
        return resultString
        
    }
    
    private func localizeLikes(count: UInt) -> String {
        let formatString: String = NSLocalizedString("likes count", comment: "likes count title")
        let resultString: String = String.localizedStringWithFormat(formatString, count)
        return resultString
        
    }
    
    private func setupLayout() {
        contentView.addSubview(authorName)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(addButton)

        let constraints = [
            authorName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            addButton.centerYAnchor.constraint(equalTo: authorName.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 16),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
