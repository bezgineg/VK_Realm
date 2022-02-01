//
//  UIDevice+Extensions.swift
//  Navigation
//
//  Created by user212151 on 2/1/22.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIDevice {
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
