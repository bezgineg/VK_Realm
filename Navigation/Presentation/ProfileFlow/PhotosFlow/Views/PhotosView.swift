//
//  PhotosView.swift
//  Navigation
//
//  Created by Евгений on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class PhotosView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        cv.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self)
        )
        cv.toAutoLayout()
        return cv
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
        addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
