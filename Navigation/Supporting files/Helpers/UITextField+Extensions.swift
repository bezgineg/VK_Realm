//
//  UITextField+Extensions.swift
//  Navigation
//
//  Created by Евгений on 29.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UITextField {
    func setupTextField() {
        let colorSet = UIColor(red: 72/255, green: 133/255, blue: 204/255, alpha: 1)
        textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        tintColor = colorSet
        backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        autocapitalizationType = .none
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
    }
}
