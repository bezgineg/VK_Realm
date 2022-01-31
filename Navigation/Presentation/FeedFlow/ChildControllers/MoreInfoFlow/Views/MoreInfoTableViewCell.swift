//
//  MoreInfoTableViewCell.swift
//  Navigation
//
//  Created by Евгений on 31.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class MoreInfoTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBackgroundColor()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(with indexPath: Int) {
        switch indexPath {
        case 0:
            mainLabel.text = FeedFlowLocalization.hideTitle.localizedValue
        case 1:
            mainLabel.text = FeedFlowLocalization.addTitle.localizedValue
        default:
            break
        }
    }

    // MARK: - Private methods
    
    private func setupBackgroundColor() {
        contentView.backgroundColor = .white
    }
    
    private func addSubviews() {
        contentView.addSubview(mainLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            mainLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
