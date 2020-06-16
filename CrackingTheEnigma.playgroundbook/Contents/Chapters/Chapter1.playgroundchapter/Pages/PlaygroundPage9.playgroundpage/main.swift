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

let enigmaMachine = DIYMachineViewController()
//#-end-hidden-code

//: # Do your own messages!
//: Now, you just know how to configure an Enigma Machine to create your own encrypted messages.
//: ### Add your own settings and run this code to create your enigmas! 😉

enigmaMachine.rotorsNumbers = [/*#-editable-code state name*/"I"/*#-end-editable-code*/, /*#-editable-code state name*/"II"/*#-end-editable-code*/, /*#-editable-code state name*/"III"/*#-end-editable-code*/]

enigmaMachine.ringSettings = [/*#-editable-code state name*/"A"/*#-end-editable-code*/, /*#-editable-code state name*/"B"/*#-end-editable-code*/, /*#-editable-code state name*/"C"/*#-end-editable-code*/]

enigmaMachine.plugboardSettings = /*#-editable-code state name*/["AB", "CE", "LF", "XU"]/*#-end-editable-code*/

//: # Wow, you created amazing enigmas! I hope you liked it 😁
//: ## Thank you for coming with me on this journey! See you 👋
//: Special thanks to Futeromono for the song New Horizons.

//#-hidden-code
PlaygroundPage.current.liveView = enigmaMachine
//#-end-hidden-code
