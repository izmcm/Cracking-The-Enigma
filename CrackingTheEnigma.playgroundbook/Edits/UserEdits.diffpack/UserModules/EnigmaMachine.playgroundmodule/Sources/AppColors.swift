
import UIKit

public enum AppColors {
    case darkBlue, white, black, whiteWithAlpha, red, green, yellow, mediumBlue, veryDarkBlue, lightGreen, lightRed
    
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
            return UIColor(red: CGFloat(193.0/255.0), 
                           green: CGFloat(157.0/255.0),
                           blue: CGFloat(0), 
                           alpha: 1) //F5D652
        case .mediumBlue:
            return UIColor(red: CGFloat(49.0/255.0), 
                           green: CGFloat(72.0/255.0),
                           blue: CGFloat(93.0/255.0), 
                           alpha: 1) //C19D00
        case .veryDarkBlue:
            return UIColor(red: CGFloat(0.0), 
                           green: CGFloat(7.0/255.0),
                           blue: CGFloat(17.0/255.0), 
                           alpha: 1) //000711
        case .lightGreen:
            return UIColor(red: CGFloat(131.0/255.0), 
                               green: CGFloat(214.0/255.0),
                               blue: CGFloat(93.0/255.0), 
                               alpha: 1) //83D65D
        case .lightRed:
            return UIColor(red: CGFloat(255.0/255.0), 
                           green: CGFloat(78.0/255.0),
                           blue: CGFloat(78.0/255.0), 
                           alpha: 1) //FF4E4E
        }
    }
}

extension AppColors {
    static let plugboardColors: [UIColor] = [UIColor(red: CGFloat(131.0/255.0), 
                                                     green: CGFloat(214.0/255.0),
                                                     blue: CGFloat(93.0/255.0), alpha: 1), 
                                             UIColor(red: CGFloat(70.0/255.0), 
                                                     green: CGFloat(74.0/255.0),
                                                     blue: CGFloat(139.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(24.0/255.0), 
                                                     green: CGFloat(161.0/255.0),
                                                     blue: CGFloat(170.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(191.0/255.0), 
                                                     green: CGFloat(98.0/255.0),
                                                     blue: CGFloat(160.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(105.0/255.0), 
                                                     green: CGFloat(20.0/255.0),
                                                     blue: CGFloat(123.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(14.0/255.0), 
                                                     green: CGFloat(98.0/255.0),
                                                     blue: CGFloat(60.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(245.0/255.0), 
                                                     green: CGFloat(214.0/255.0),
                                                     blue: CGFloat(82.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(192.0/255.0), 
                                                     green: CGFloat(165.0/255.0),
                                                     blue: CGFloat(126.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(253.0/255.0), 
                                                     green: CGFloat(83.0/255.0),
                                                     blue: CGFloat(31.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(195.0/255.0), 
                                                     green: CGFloat(82.0/255.0),
                                                     blue: CGFloat(37.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(238.0/255.0), 
                                                     green: CGFloat(84.0/255.0),
                                                     blue: CGFloat(84.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(130.0/255.0), 
                                                     green: CGFloat(130.0/255.0),
                                                     blue: CGFloat(130.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(216.0/255.0), 
                                                     green: CGFloat(0.0/255.0),
                                                     blue: CGFloat(194.0/255.0), alpha: 1),
                                             UIColor(red: CGFloat(88.0/255.0), 
                                                     green: CGFloat(28.0/255.0),
                                                     blue: CGFloat(12.0/255.0), alpha: 1)]
}
