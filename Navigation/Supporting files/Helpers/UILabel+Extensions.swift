//
//  UILabel+Extensions.swift
//  Navigation
//
//  Created by Евгений on 29.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setupLabel() {
        toAutoLayout()
        font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
    }
}
