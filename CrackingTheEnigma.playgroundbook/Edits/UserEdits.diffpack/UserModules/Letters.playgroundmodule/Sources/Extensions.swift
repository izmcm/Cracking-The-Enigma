import UIKit
import AVFoundation

extension UITextView {
    func setText(_ typedText: String, withDelay delay: TimeInterval) {
        var sound: [AVAudioPlayer?] = []
        for i in 1...4 {
            sound.append(self.setKeySong(soundNumber: i))
        }
        
        let characterArray = Array(typedText)
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { (timer) in
            while characterArray[characterIndex] == " " {
                self.text.append(" ")
                characterIndex += 1
                if characterIndex == characterArray.count {
                    timer.invalidate()
                    return
                }
            }
            
            let idx = Int.random(in: 0...sound.count - 1)
            sound[idx]?.play()
            self.text.append(characterArray[characterIndex])
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
                
            }
        }
    }
    
    func setKeySong(soundNumber: Int) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: "key\(soundNumber)", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do { return try AVAudioPlayer(contentsOf: url) }
            catch { }
        }
        return nil
    }
}

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
