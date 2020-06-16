//#-hidden-code
import  UIKit
import  PlaygroundSupport
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

let loadingViewController = LoadingViewController()
loadingViewController.isFirstText = true

nav.addChild(loadingViewController)

var rootViewController = nav

PlaygroundPage.current.liveView = rootViewController
//#-end-hidden-code

//: # Hello! Nice to meet you 😆
//: I'm Izabella! If you run this page, you will see that you receive a important letter, right?
//: 
//: I know you must be wondering how you are going to do this, but relax!
//: I will help you 😉
//: # What's an Enigma Machine?
//: Enigma was a machine used during World War II to encrypt radio messages.
//:
//: You will play with an simulator, made entirely in Swift, which mimics the mechanics of operation of an original Enigma machine.
//:### Are you ready?? Run the code and let's go!
