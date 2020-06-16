import Foundation
import UIKit

class KeyboardKeys {
    let keys = ["Q", "W", "E", "R", "T", "Z", "U", "I", "O",
                "A", "S", "D", "F", "G", "H", "J", "K",
                "P", "Y", "X", "C", "V", "B", "N", "M", "L",
                "_", "."]
    
    func getLine(_ line: Int) -> [String] {
        switch line {
        case 0:
            return Array(keys[0..<9])
        case 1:
            return Array(keys[9..<17])
        case 2:
            return Array(keys[17..<26])
        default:
            return Array(keys[26...])
        }
        
    }
}
