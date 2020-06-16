import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true 
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

extension UIFont {
    static func setSizeByStyle(style: TextStyle) -> UIFont {
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let pointSize = userFont.pointSize
        return UIFont.systemFont(ofSize: pointSize)
    }
}
