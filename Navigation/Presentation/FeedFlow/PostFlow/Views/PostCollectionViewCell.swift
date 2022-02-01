//
//  PostCollectionViewCell.swift
//  Navigation
//
//  Created by user212151 on 2/1/22.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol PostCollectionViewCellDelegate: AnyObject {
    func postCollectionViewCell(
        _ postCollectionViewCell: PostCollectionViewCell,
        showMoreButtonTappedAt index: Int
    )
}

final class PostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    public weak var delegate: PostCollectionViewCellDelegate?
    
    // MARK: - Private Properties
    
    private var currentIndex = 0
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var showMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
        button.isExclusiveTouch = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCellView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setupCell(index: Int, author: Author) {
        currentIndex = index
        backgroundImageView.image = author.images[index]
    }
    
    // MARK: - Private Methods
    
    @objc private func showMoreButtonTapped() {
        delegate?.postCollectionViewCell(self, showMoreButtonTappedAt: currentIndex)
    }
    
    private func setupCellView() {
        backgroundColor = .white
        contentView.layer.cornerRadius = 24
        layer.cornerRadius = 24
        clipsToBounds = true
    }
    
    private func addSubviews() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(showMoreButton)
    }
    
    private func setupConstraints() {
        let constraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            showMoreButton.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 8),
            showMoreButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -8),
            showMoreButton.widthAnchor.constraint(equalToConstant: 48),
            showMoreButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
