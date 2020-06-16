import UIKit

public enum AppColors {
    case darkBlue, white, black, whiteWithAlpha, red, green, yellow, mediumBlue
    
    public var uiColor: UIColor {
        switch self {
        case .darkBlue:
            return UIColor(red: CGFloat(34.0/255.0), 
                           green: CGFloat(40.0/255.0),
                           blue: CGFloat(49.0/255.0), 
                           alpha: 1) //222831
        case .white:
            return UIColor(red: CGFloat(236.0/255.0), 
                           green: CGFloat(236.0/255.0),
                           blue: CGFloat(236.0/255.0), 
                           alpha: 1) //ECECEC
        case .black:
            return UIColor(red: CGFloat(24.0/255.0), 
                           green: CGFloat(28.0/255.0),
                           blue: CGFloat(33.0/255.0), 
                           alpha: 1) //181C21
        case .whiteWithAlpha:
            return UIColor(red: CGFloat(236.0/255.0), 
                           green: CGFloat(236.0/255.0),
                           blue: CGFloat(236.0/255.0), 
                           alpha: 0.5)
        case .red:
            return UIColor(red: CGFloat(184.0/255.0), 
                           green: CGFloat(0.0/255.0),
                           blue: CGFloat(0.0/255.0), 
                           alpha: 1) //C85223
        case .green:
            return UIColor(red: CGFloat(14.0/255.0), 
                           green: CGFloat(98.0/255.0),
                           blue: CGFloat(60.0/255.0), 
                           alpha: 1) //0E623C
        case .yellow:
            return UIColor(red: CGFloat(245.0/255.0), 
                           green: CGFloat(214.0/255.0),
                           blue: CGFloat(82.0/255.0), 
                           alpha: 1) //F5D652
        case .mediumBlue:
            return UIColor(red: CGFloat(49.0/255.0), 
                           green: CGFloat(72.0/255.0),
                           blue: CGFloat(93.0/255.0), 
                           alpha: 1) //31485D
        }
    }
}
