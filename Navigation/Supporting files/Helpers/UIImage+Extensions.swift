//
//  UIImage+Extensions.swift
//  Navigation
//
//  Created by Евгений on 29.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
