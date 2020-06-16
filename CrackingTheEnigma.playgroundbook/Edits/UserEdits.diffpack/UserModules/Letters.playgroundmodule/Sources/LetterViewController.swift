import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class LetterViewController: UIViewController {
    let firstText = "Dear citzen,\n\nAmerica needs your help!\n\nAt the beginning of the month, we captured an Enigma Code Book from our enemies. For this reason, we think they are using an Enigma machine to write their messages. We just intercepted a radio message and it's encrypted.\n\nWe know you have one of America's last Enigma machines!\n\nI'm sending you an copy of the Enigma Code Book and the message that we need to decrypt.\n\nYou have 3 minutes. Be quick!\n\nSee you later."
    
    let secondText = "Dear citizen,\n\nHello again! I just got your message and, well... I have no words. Don't worry, it wasn't your fault. I talked to some experts and they informed me that this must have been some interference with the radio signal we picked up. Apparently this message came from a girl in Brazil. She seems to really want this jacket...\n\nI'm very embarrassed about all of this, but at least now you know how to use an Enigma machine to write and decipher messages, right? If you want, you can freely write more secret messages on the next page... but STAY AWAY FROM THE RADIO SIGNS!\n\nAmerica thanks you for your help!"
    
    var letterLabel = UITextView()
    var letsGoButton = UIButton()
    var buttonSound: AVAudioPlayer?
    
    public var isFirstText = true
    
    public override func viewDidLoad() {
        self.view.backgroundColor = AppColors.darkBlue.uiColor
        buttonSound = setButtonSong()
        
        addButton()
        addLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 28.0){ 
            self.letsGoButton.isHidden = false
        }

    }
    
    func setButtonSong() -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: "button", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do { return try AVAudioPlayer(contentsOf: url) }
            catch { }
        }
        return nil
    }
    
    func addLabel() {
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if isFirstText {
            letterLabel.setText(firstText, withDelay: 0.08)
        } else {
            letterLabel.setText(secondText, withDelay: 0.08)
        }
        
        letterLabel.textColor = AppColors.white.uiColor
        letterLabel.textAlignment = .left
        letterLabel.backgroundColor = .clear
        letterLabel.font = UIFont.setSizeByStyle(style: .title3)
        letterLabel.textColor = AppColors.white.uiColor
        
        self.view.addSubview(letterLabel)
        addLabelConstraints()
    }
    
    func addButton() {
        letsGoButton.translatesAutoresizingMaskIntoConstraints = false
        letsGoButton.isHidden = true
        letsGoButton.setBackgroundColor(AppColors.green.uiColor, forState: .normal)
        letsGoButton.setBackgroundColor(AppColors.black.uiColor, forState: .selected)
        letsGoButton.setTitle("Let's go!", for: .normal)
        
        letsGoButton.layer.cornerRadius = 3
        letsGoButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        letsGoButton.layer.shadowColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        letsGoButton.layer.shadowRadius = 2
        
        letsGoButton.addTarget(self, action: #selector(nextPlaygroundPage), for: .touchUpInside)
        self.view.addSubview(letsGoButton)
        addButtonConstraints()
    }
    
    @objc func nextPlaygroundPage() {
        buttonSound?.play()
        PlaygroundPage.current.navigateTo(page: .next)
    }
    
    // MARK: CONSTRAINTS
    func addLabelConstraints() {
        NSLayoutConstraint.activate([ 
            letterLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0), 
            letterLabel.topAnchor.constraint(lessThanOrEqualTo: self.view.topAnchor, constant: 100),
            letterLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            letterLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
        ])
        
    }
    
    func addButtonConstraints() {
        NSLayoutConstraint.activate([ 
            letsGoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            letsGoButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2),
            self.letsGoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint(item: letsGoButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 6/7, constant: 0).isActive = true
        
    }
    
}
