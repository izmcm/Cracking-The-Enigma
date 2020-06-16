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
loadingViewController.isFirstText = false

nav.addChild(loadingViewController)

var rootViewController = nav

PlaygroundPage.current.liveView = rootViewController
//#-end-hidden-code

//: # Wait! WHAT?!
//: I'm sure we did everything right...
//: ### It's better run the page to see the captain's response!
