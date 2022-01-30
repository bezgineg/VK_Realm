//
//  ProfileView.swift
//  Navigation
//
//  Created by Евгений on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class ProfileView: UIView {
    
    // MARK: - Public Properties
    
    public var onCancelAnimationTap: (() -> Void)?
    
    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dragInteractionEnabled = true
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: String(describing: PhotosTableViewCell.self)
        )
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private var avatarWidthConstraint = NSLayoutConstraint()
    private var avatarHeightConstraint = NSLayoutConstraint()
    private var avatarTopConstraint = NSLayoutConstraint()
    private var avatarLeadingConstraint = NSLayoutConstraint()
    
    private lazy var cancelAnimationButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.backgroundColor = UIColor.white.withAlphaComponent(0)
        button.setTitleColor(UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white), for: .normal)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelAnimationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderColor = UIColor.createColor(
            lightMode: Colors.white,
            darkMode: Colors.black
        ).cgColor
        avatarImageView.layer.borderWidth = 3
        return avatarImageView
    }()
    
    private let photoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return view
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func addAvatar(image: UIImage?) {
        avatarImageView.image = image
        addAvatarImage()
        animateAvatar()
    }
    
    // MARK: - Private Methods
    
    @objc private func cancelAnimationButtonTapped() {
        removeAvatar()
    }
    
    private func addAvatarImage() {
        avatarWidthConstraint = avatarImageView.widthAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.width
        )
        avatarHeightConstraint = avatarImageView.heightAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.width
        )
        avatarTopConstraint = avatarImageView.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: UIScreen.main.bounds.height / 2 - avatarHeightConstraint.constant / 2 - safeAreaInsets.top
        )
        avatarLeadingConstraint = avatarImageView.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 0
        )
        
        addSubview(photoView)
        photoView.addSubview(avatarImageView)
        
        let constratints = [
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            avatarTopConstraint,
            avatarLeadingConstraint,
            avatarWidthConstraint,
            avatarHeightConstraint
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
    
    private func animateAvatar() {
        UIView.animate(
            withDuration: 0.5,
            animations: { [self] in
                layoutIfNeeded()
            },
            completion: { [self] _ in
                addCancelAnimationButton()
            }
        )
    }
    
    private func removeAvatar() {
        cancelAnimationButton.removeFromSuperview()
        avatarWidthConstraint.constant = 100
        avatarHeightConstraint.constant = 100
        avatarLeadingConstraint.constant = 16
        avatarTopConstraint.constant = 16
        UIView.animate(
            withDuration: 0.5,
            animations: { [self] in
                layoutIfNeeded()
            },
            completion: { [self] _ in
                photoView.removeFromSuperview()
                avatarWidthConstraint.constant = UIScreen.main.bounds.width
                avatarHeightConstraint.constant = UIScreen.main.bounds.width
                avatarLeadingConstraint.constant = 0
                avatarTopConstraint.constant = UIScreen.main.bounds.height / 2 -
                avatarHeightConstraint.constant / 2 - safeAreaInsets.top
                onCancelAnimationTap?()
            }
        )
    }
    
    private func addCancelAnimationButton() {
        photoView.addSubview(cancelAnimationButton)
        let constratints = [
            cancelAnimationButton.bottomAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: -16),
            cancelAnimationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cancelAnimationButton.widthAnchor.constraint(equalToConstant: 44),
            cancelAnimationButton.heightAnchor.constraint(equalToConstant: 44),
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
    
    private func setupLayout() {
        addSubview(tableView)
        let constratints = [
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constratints)

    }
}
