import Foundation

// Vamos sempre mapear um valor para um
// outro, ou seja, um valor A para B
struct Mapping<A, B> {
    let from: A
    let to: B
}

struct MachineConfiguration {
    let plugboardMappings: [Mapping<Int, Int>]
    let rotors: [Int]
    let rotorSettings: [Int]
}

