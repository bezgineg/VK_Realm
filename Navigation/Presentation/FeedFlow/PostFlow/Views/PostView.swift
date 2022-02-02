//
//  PostView.swift
//  Navigation
//
//  Created by user212151 on 2/1/22.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostView: UIView {
    
    // MARK: - Public Properties
    
    public let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(
            PostCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self)
        )
        cv.toAutoLayout()
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    // MARK: - Private Properties
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        label.text = FeedFlowLocalization.mainLabel.localizedValue
        label.layer.zPosition = 1
        label.toAutoLayout()
        return label
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(mainLabel)
        addSubview(collectionView)
        
        let constraints = [
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
