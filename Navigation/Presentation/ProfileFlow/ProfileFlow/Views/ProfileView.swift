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
    
    private lazy var cancelAnimationButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.backgroundColor = UIColor.white.withAlphaComponent(0)
        button.setTitleColor(UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white), for: .normal)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = true
        button.addTarget(self, action: #selector(cancelAnimationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
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
