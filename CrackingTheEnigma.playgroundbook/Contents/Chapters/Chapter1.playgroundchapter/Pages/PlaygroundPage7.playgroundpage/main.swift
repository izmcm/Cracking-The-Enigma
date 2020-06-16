//#-hidden-code
import PlaygroundSupport
import UIKit
import AVFoundation

var sound: AVAudioPlayer?
if let path = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3") {
    let url = URL(fileURLWithPath: path)
    do {
        sound = try AVAudioPlayer(contentsOf: url)
        sound?.volume = 0.05
        sound?.numberOfLoops = -1
        sound?.play()
    }
    catch { }
}

let nav = UINavigationController()
nav.isNavigationBarHidden = true

let configureViewController = ConfigureRotorsViewController()
//#-end-hidden-code

//: # Run the code to see the required Enigma machine settings!
//: The enigma machine produces a symmetric cipher, that is, to decrypt an encrypted text, just have the same initial configuration.
//:
//: ## Rotors Numbers
//: Rotors are responsible for transforming one letter into another, never in itself.
//: We call this the substitution cipher!
//: ##### Our Enigma machine has three replaceable rotors, you can choose from I to VI in any order, but you can't repeat. The encryption depends on the rotors chosen and the order they are.

configureViewController.rotorsNumbers = [/*#-editable-code state name*/"I"/*#-end-editable-code*/, /*#-editable-code state name*/"II"/*#-end-editable-code*/, /*#-editable-code state name*/"III"/*#-end-editable-code*/]

//: ## Ring Settings
//: Each rotor will be a ring setting, responsible for shift all outputs by the corresponding number in the alphabet. For example, if the Ring Setting of the first rotor is A then all the outputs will be shifted the alphabet by one.
//: ##### You can choose from A to Z bellow

configureViewController.ringSettings = [/*#-editable-code state name*/"A"/*#-end-editable-code*/, /*#-editable-code state name*/"B"/*#-end-editable-code*/, /*#-editable-code state name*/"C"/*#-end-editable-code*/]

//: ## Plugboard
//: The Plugboard was a board for connecting letters. If you define AC, the letter A will be connected to C, then A will behave as if it were C and vice versa.
//: ##### You can add as many pairs of letters as you like, as long as you don't repeat the letters

configureViewController.plugboardSettings = /*#-editable-code state name*/["AB", "CE", "LF", "XU"]/*#-end-editable-code*/

//#-hidden-code
nav.addChild(configureViewController)
var rootViewController = nav

PlaygroundPage.current.liveView = rootViewController
//#-end-hidden-code
