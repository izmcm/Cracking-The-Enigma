
import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class ConfigurePlugboardViewController: UIViewController, ViewCode {

    public var rotorsNumbers: [String] = ["I", "IV", "VI"]
    public var ringSettings: [String] = ["D", "A", "C"]
    public var plugboardSettings: [String] = ["AJ", "GH", "ZY", "OK"]
    
    private let answerPlugboard = ["AP", "LE", "MJ", "OK"]
    
    var messageGameView = UILabel()
    var gameInstruction = UILabel()
    var plugboardTitle = UILabel()
    var plugboard = UIView()
    
    // enigma code book
    var dateTitleCodeBook = UILabel()
    var rotorsTitleCodeBook = UILabel()
    var ringTitleCodeBook = UILabel()
    var plugboardTitleCodeBook = UILabel()
    
    var dateCodeBook = UILabel()
    var rotorsCodeBook = UILabel()
    var ringCodeBook = UILabel()
    var plugboardCodeBook = UILabel()
    var buttonSound: AVAudioPlayer?
    
    let blackView: (String) -> UILabel = { str in
        let view = UILabel()
        view.text = str 
        view.font = UIFont.setSizeByStyle(style: .largeTitle)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.layer.borderColor = AppColors.white.uiColor.cgColor
        view.layer.borderWidth = 2
        view.backgroundColor = AppColors.veryDarkBlue.uiColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        return view
    }
    
    let textLabel: (String, UIFont.TextStyle) -> UILabel = { str, size in
        let view = UILabel()
        view.text = str
        view.font = UIFont.setSizeByStyle(style: size)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    let nextButton: UIButton = {
        let view = UIButton()
        view.setBackgroundColor(AppColors.green.uiColor, forState: .normal)
        view.setBackgroundColor(AppColors.black.uiColor, forState: .selected)
        view.setBackgroundColor(AppColors.black.uiColor, forState: .disabled)
        view.setTitle("Decrypt!", for: .normal)
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override func viewDidLoad() {
        buttonSound = setButtonSong()
        setupView()
        
        if plugboardSettings != answerPlugboard {
            nextButton.isEnabled = false
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
    
    func buildView() {
        messageGameView = blackView("")
        self.view.addSubview(messageGameView)
        
        gameInstruction = textLabel("Write the Enigma Code Book instructions in the code and execute to see them below. If all is right, you can go to next page!", .title2)
        self.view.addSubview(gameInstruction)
        
        plugboardTitle = textLabel("Plugboard", .largeTitle)
        self.view.addSubview(plugboardTitle)
        
        let plugboardSize = CGRect(x: self.view.frame.size.width*0.15, y: self.view.frame.size.height*0.5 - 100, width: self.view.frame.size.width*0.7, height: 300)
        plugboard = PlugboadView(size: plugboardSize,
                                 settings: plugboardSettings)
        self.view.addSubview(plugboard)
        
        self.view.addSubview(nextButton)
        
        dateTitleCodeBook = textLabel("Date", .title2)
        rotorsTitleCodeBook = textLabel("Rotors\nNumbers", .title2)
        ringTitleCodeBook = textLabel("Ring\nSettings", .title2)
        plugboardTitleCodeBook = textLabel("Plugboard", .title2)
        
        dateCodeBook = textLabel("\(getToday())", .title1)
        rotorsCodeBook = textLabel("IV I III", .title1)
        ringCodeBook = textLabel("T I M", .title1)
        plugboardCodeBook = textLabel("AP LE MJ OK", .title1)
        
        self.view.addSubview(dateTitleCodeBook)
        self.view.addSubview(rotorsTitleCodeBook)
        self.view.addSubview(ringTitleCodeBook)
        self.view.addSubview(plugboardTitleCodeBook)
        
        self.view.addSubview(dateCodeBook)
        self.view.addSubview(rotorsCodeBook)
        self.view.addSubview(ringCodeBook)
        self.view.addSubview(plugboardCodeBook)
    }
    
    func setupConstraints() {
        messageGameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        messageGameView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        messageGameView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        messageGameView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        dateTitleCodeBook.leftAnchor.constraint(equalTo: messageGameView.leftAnchor, constant: 20).isActive = true
        dateTitleCodeBook.centerYAnchor.constraint(equalTo: rotorsTitleCodeBook.centerYAnchor).isActive = true
        
        dateCodeBook.centerXAnchor.constraint(equalTo: dateTitleCodeBook.centerXAnchor).isActive = true
        dateCodeBook.centerYAnchor.constraint(equalTo: rotorsCodeBook.centerYAnchor, constant: 0).isActive = true
        
        rotorsTitleCodeBook.leftAnchor.constraint(greaterThanOrEqualTo: dateTitleCodeBook.rightAnchor, constant: 20).isActive = true
        rotorsTitleCodeBook.leftAnchor.constraint(lessThanOrEqualTo: dateTitleCodeBook.rightAnchor, constant: 50).isActive = true
        rotorsTitleCodeBook.bottomAnchor.constraint(equalTo: messageGameView.centerYAnchor).isActive = true
        
        rotorsCodeBook.centerXAnchor.constraint(equalTo: rotorsTitleCodeBook.centerXAnchor).isActive = true
        rotorsCodeBook.topAnchor.constraint(equalTo: messageGameView.centerYAnchor, constant: 10).isActive = true
        
        ringTitleCodeBook.leftAnchor.constraint(greaterThanOrEqualTo: rotorsTitleCodeBook.rightAnchor, constant: 20).isActive = true
        ringTitleCodeBook.leftAnchor.constraint(lessThanOrEqualTo: rotorsTitleCodeBook.rightAnchor, constant: 50).isActive = true
        ringTitleCodeBook.centerYAnchor.constraint(equalTo: rotorsTitleCodeBook.centerYAnchor, constant: 0).isActive = true
        
        ringCodeBook.centerXAnchor.constraint(equalTo: ringTitleCodeBook.centerXAnchor).isActive = true
        ringCodeBook.centerYAnchor.constraint(equalTo: rotorsCodeBook.centerYAnchor, constant: 0).isActive = true
        
        plugboardTitleCodeBook.leftAnchor.constraint(greaterThanOrEqualTo: ringTitleCodeBook.rightAnchor, constant: 40).isActive = true
        plugboardTitleCodeBook.leftAnchor.constraint(lessThanOrEqualTo: ringTitleCodeBook.rightAnchor, constant: 80).isActive = true
        
        plugboardTitleCodeBook.centerYAnchor.constraint(equalTo: rotorsTitleCodeBook.centerYAnchor, constant: 0).isActive = true
        plugboardTitleCodeBook.rightAnchor.constraint(greaterThanOrEqualTo: messageGameView.rightAnchor, constant: -50).isActive = true
        
        plugboardCodeBook.centerXAnchor.constraint(equalTo: plugboardTitleCodeBook.centerXAnchor).isActive = true
        plugboardCodeBook.centerYAnchor.constraint(equalTo: rotorsCodeBook.centerYAnchor, constant: 0).isActive = true
        
        gameInstruction.topAnchor.constraint(equalTo: self.messageGameView.bottomAnchor, constant: 20).isActive = true
        gameInstruction.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        gameInstruction.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        plugboardTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        plugboardTitle.topAnchor.constraint(greaterThanOrEqualTo: self.gameInstruction.bottomAnchor, constant: 20).isActive = true
        plugboardTitle.bottomAnchor.constraint(equalTo: plugboard.topAnchor, constant: -20).isActive = true
        
        nextButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        NSLayoutConstraint(item: nextButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 6/7, constant: 0).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    func setupAdditionalConfigs() {
        self.view.backgroundColor = AppColors.darkBlue.uiColor
        
        nextButton.addTarget(self, action: #selector(goToEnigmaMachine), for: .touchUpInside)
        
        rotorsCodeBook.alpha = 0.5
        rotorsTitleCodeBook.alpha = 0.5
        ringCodeBook.alpha = 0.5
        ringTitleCodeBook.alpha = 0.6
    }
    
    @objc func goToEnigmaMachine() {
        buttonSound?.play()
        var enigmaMachine = EnigmaMachineViewController()
        enigmaMachine.rotorsNumbers = rotorsNumbers
        enigmaMachine.ringSettings = ringSettings
        enigmaMachine.plugboardSettings = plugboardSettings
        
        self.navigationController?.pushViewController(enigmaMachine, animated: false)
    }
    
    func getToday() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day
        return String(day ?? 13)
    }
}

