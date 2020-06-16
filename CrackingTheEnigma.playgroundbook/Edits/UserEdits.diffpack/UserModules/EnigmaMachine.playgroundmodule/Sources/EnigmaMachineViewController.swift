
import Foundation
import UIKit
import PlaygroundSupport
import AVFoundation

public class EnigmaMachineViewController: UIViewController {
    public var rotorsNumbers: [String] = ["I", "IV", "VI"]
    public var ringSettings: [String] = ["D", "A", "C"]
    public var plugboardSettings: [String] = ["AJ", "GH", "ZY", "OK"]
    
    private var rotorsDict = ["I": 1, "II": 2,
                              "III": 3, "IV": 4,
                              "V": 5, "VI": 6]
    
    private var userMessage = ""
    private var gameMessage = "JXRFGBWBURWAYTHXF_BFMKWSLCMHZK"
    private var answerGame = "I_AM_DREAMING_WITH_WWDC_JACKET"
    private var messageCount = 0
    private var textIsCorrect = true
    
    private let keyboardClass = KeyboardKeys()
    private let enigmaView = EnigmaMachineView()
    private var machine: Remappable!
    private var config: MachineConfiguration!
    private var lettersMappings: [Mapping<Int, Character>] = []
    private var indexDict: [Int: Character] = [:]
    private var charDict: [Character: Int] = [:]
    private let factory = Alphabet()
    var keysSound: [AVAudioPlayer?] = []
    var buttonSound: AVAudioPlayer?
    
    public override func loadView() {
        self.view = enigmaView
    }
    
    public override func viewDidLoad() {
        self.lettersMappings = factory.lettersMappings
        createAlphabetCache()
        
        createMachine()
        configureCollectionView()
        
        enigmaView.delegate = self
        
        for i in 1...4 {
            keysSound.append(self.setKeySong(soundNumber: i))
        }
        buttonSound = setButtonSong()
    }
    
    func setKeySong(soundNumber: Int) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: "key\(soundNumber)", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do { return try AVAudioPlayer(contentsOf: url) }
            catch { }
        }
        return nil
    }
    
    func setButtonSong() -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: "button", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do { return try AVAudioPlayer(contentsOf: url) }
            catch { }
        }
        return nil
    }
    
    func configureCollectionView() {
        enigmaView.keyboard.register(keyCell.self, forCellWithReuseIdentifier: "KeyCell")
        enigmaView.keyboard.delegate = self
        enigmaView.keyboard.dataSource = self
    }
    
    func createMachine() {
        let config = MachineConfiguration(plugboardMappings: decodePlugboardSettings(),
                                          rotors: decodeRotorsNumbers(),
                                          rotorSettings: decodeRingSettings())
        
        self.config = config
        
        self.machine = factory.createMachine(withConfig: config)
    }
    
    func decodeRotorsNumbers() -> [Int] {
        var numbers: [Int] = []
        for rotor in rotorsNumbers {
            let number = rotorsDict[rotor] ?? -1
            numbers.append(number)
        }
        return numbers
    }
    
    func decodePlugboardSettings() -> [Mapping<Int, Int>] {
        var plugboardMappings: [Mapping<Int, Int>] = []
        
        for plug in plugboardSettings {
            
            let from = plug[plug.startIndex]
            let to = plug[plug.index(plug.startIndex, offsetBy: plug.count - 1)]
            plugboardMappings.append(Mapping(from: charDict[from] ?? -1, to: charDict[to] ?? -1))
        }
        
        return plugboardMappings
    }
    
    func decodeRingSettings() -> [Int] {
        var ringSettingsInt: [Int] = []
        for char in ringSettings {
            let idx = char[char.startIndex]
            let number = charDict[idx] ?? -1
            ringSettingsInt.append(number)
        }
        
        return ringSettingsInt
    }
    
    // MARK: ENIGMA FUNCTIONS
    private func createAlphabetCache() {
        for item in lettersMappings {
            self.indexDict[item.from] = item.to
            self.charDict[item.to] = item.from
        }
    }
    
    func encodeOrDecode(_ message: String) -> String {
        self.setRotors(config.rotorSettings.reversed())
        return self.remap(message)
    }
    
    private func remap(_ string: String) -> String {
        var remappedString = ""
        
        string.uppercased().forEach { (char) in
            if let charIndex = self.charDict[char] {
                let remappedIndex = self.machine.remap(charIndex)
                if let remappedChar = self.indexDict[remappedIndex] {
                    remappedString.append(remappedChar)
                }
            }
        }
        
        return remappedString
    }
    
    private func setRotors(_ setting: [Int]) {
        self.machine.reset()
        self.machine.shift(by: setting)
    }
}

// MARK: ENIGMA DELEGATE
extension EnigmaMachineViewController: EnigmaDelegate {
    func nextPage() {
        PlaygroundPage.current.navigateTo(page: .next)
    }

    func cleanAllAction() {
        buttonSound?.play()
        buttonSound?.prepareToPlay()
        userMessage = ""
        enigmaView.firstTextField.text = ""
        messageCount = 0
        enigmaView.messageGameView.text = gameMessage
        textIsCorrect = true
    }
    
    func runMessage() {
        buttonSound?.play()
        buttonSound?.prepareToPlay()
        let resultMessage = encodeOrDecode(userMessage)
        enigmaView.firstTextField.text = resultMessage
        
        if resultMessage == answerGame {
            enigmaView.endGame()
        }
    }
}

// MARK: COLLECTIONVIEW DELEGATES
extension EnigmaMachineViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let keyPressed = keyboardClass.getLine(indexPath.section)[indexPath.row]
        userMessage += keyPressed
        
        // reload textview
        enigmaView.firstTextField.text = userMessage
        let soundIDX = Int.random(in: 0...keysSound.count - 1)
        keysSound[soundIDX]?.play()
        keysSound[soundIDX]?.prepareToPlay()
        
        // if the text is correct
        let idx = gameMessage.index(gameMessage.startIndex, offsetBy: messageCount)
        let gameMsgAttrString = NSMutableAttributedString(string: gameMessage) 
        
        if keyPressed == String(gameMessage[idx]) && textIsCorrect {
            let greenAttribute = [NSAttributedString.Key.foregroundColor: AppColors.lightGreen.uiColor]
            let greenRange = NSRange(location: 0, length: messageCount + 1)
            
            gameMsgAttrString.addAttributes(greenAttribute, range: greenRange)
            
            enigmaView.messageGameView.attributedText = gameMsgAttrString
            messageCount += 1
        } else { // if not
            let greenAttribute = [NSAttributedString.Key.foregroundColor: AppColors.lightGreen.uiColor]
            let redAttribute = [NSAttributedString.Key.foregroundColor: AppColors.red.uiColor]
            
            let greenRange = NSRange(location: 0, length: messageCount)
            let redRange = NSRange(location: messageCount, length: 1)
            
            gameMsgAttrString.addAttributes(greenAttribute, range: greenRange)
            gameMsgAttrString.addAttributes(redAttribute, range: redRange)
            
            enigmaView.messageGameView.attributedText = gameMsgAttrString
            
            textIsCorrect = false
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? keyCell {
            cell.backgroundColor = AppColors.black.uiColor
            cell.charLabel.textColor = .gray
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? keyCell {
            cell.backgroundColor = AppColors.darkBlue.uiColor
            cell.charLabel.textColor = AppColors.white.uiColor
        }
    }
}

extension EnigmaMachineViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboardClass.getLine(section).count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyCell", for: indexPath as IndexPath) as? keyCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = cell.frame.size.height/2
        cell.layer.masksToBounds = true
        cell.backgroundColor = AppColors.darkBlue.uiColor
        cell.charLabel.text = keyboardClass.getLine(indexPath.section)[indexPath.row]
        cell.charLabel.textColor = .white
        return cell
    }
}

extension EnigmaMachineViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let viewWidthOriginal = self.view.frame.width*0.8
        
        switch section {
        case 3:
            return viewWidthOriginal/4 
        default:
            return 3.0 
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let viewWidthOriginal = self.view.frame.width*0.8
        var viewWidth = (viewWidthOriginal - 8*3.0) - 20
        let defaultKeyWidth = viewWidth/9.0
        
        let viewHeightOriginal = self.view.frame.height*0.35
        let viewHeight = viewHeightOriginal - defaultKeyWidth*4.0
        let defaultKeyHeight = viewHeight/5
        
        switch section {
        case 1:
            return UIEdgeInsets(top: defaultKeyHeight, 
                                left: defaultKeyWidth/2, 
                                bottom: 0, 
                                right: defaultKeyWidth/2)
        case 3:
            return UIEdgeInsets(top: defaultKeyHeight, 
                                left: 3*defaultKeyWidth/2, 
                                bottom: 0, 
                                right: 3*defaultKeyWidth/2) 
        default:
            return UIEdgeInsets(top: defaultKeyHeight,
                                left: 10, bottom: 0, right: 10)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidthOriginal = self.view.frame.width*0.8
        
        var viewWidth = (viewWidthOriginal - 8*3.0) - 20
        let defaultKeyWidth = viewWidth/9.0
        
        return CGSize(width: defaultKeyWidth, height: defaultKeyWidth) 
    }
}

