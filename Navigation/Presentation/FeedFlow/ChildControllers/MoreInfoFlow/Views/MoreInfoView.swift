//
//  MoreInfoView.swift
//  Navigation
//
//  Created by Евгений on 31.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class MoreInfoView: UIView {
    
    // MARK: - Public properties
    
    public let moreInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tableView.register(
            MoreInfoTableViewCell.self,
            forCellReuseIdentifier: String(describing: MoreInfoTableViewCell.self)
        )
        return tableView
    }()

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundColor()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupBackgroundColor() {
        backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
    }
    
    private func addSubviews() {
        addSubview(moreInfoTableView)
    }
    
    private func setupConstraints() {
        let constraints = [
            moreInfoTableView.topAnchor.constraint(equalTo: topAnchor),
            moreInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moreInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreInfoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
