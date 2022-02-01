//
//  UIImageView+Extensions.swift
//  Navigation
//
//  Created by Евгений on 29.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIImageView {
    func setupImages() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 6
    }
}
