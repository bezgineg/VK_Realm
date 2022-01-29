
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection ) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

extension UIView {
    
    /// Method adds shadow and corner radius for top of view by default.
    ///
    /// - Parameters:
    ///   - top: Top corners
    ///   - bottom: Bottom corners
    ///   - radius: Corner radius
    func roundCornersWithRadius(_ radius: CGFloat, top: Bool? = true, bottom: Bool? = true, shadowEnabled: Bool = true) {
        var maskedCorners = CACornerMask()
        
        if shadowEnabled {
            clipsToBounds = true
            layer.masksToBounds = false
            layer.shadowOpacity = 0.7
            layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        switch (top, bottom) {
        case (true, false):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case (false, true):
            maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case (true, true):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            break
        }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
}

extension UIView {
    
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITextField {
    func setupTextField() {
        let colorSet = UIColor(red: 72/255, green: 133/255, blue: 204/255, alpha: 1)
        self.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
        self.tintColor = colorSet
        self.backgroundColor = UIColor.createColor(lightMode: Colors.white, darkMode: Colors.black)
        self.autocapitalizationType = .none
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UILabel {
    
    func setupLabel() {
        self.toAutoLayout()
        self.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.textColor = UIColor.createColor(lightMode: Colors.black, darkMode: Colors.white)
    }
}

extension UIImageView {
    
    func setupImages() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
    }
}
