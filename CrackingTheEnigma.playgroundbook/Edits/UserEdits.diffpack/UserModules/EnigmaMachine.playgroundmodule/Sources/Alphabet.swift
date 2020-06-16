
import Foundation

public class Alphabet: MachineFactory {
    private let reflectorMappings = [
        Mapping(from: 0, to: 11), Mapping(from: 1, to: 19),
        Mapping(from: 2, to: 6), Mapping(from: 3, to: 23),
        Mapping(from: 4, to: 10), Mapping(from: 5, to: 16), 
        Mapping(from: 7, to: 25), Mapping(from: 8, to: 12), 
        Mapping(from: 9, to: 20), Mapping(from: 13, to: 15),
        Mapping(from: 14, to: 22), Mapping(from: 17, to: 24), 
        Mapping(from: 18, to: 26), Mapping(from: 21, to: 27)
    ]
    
    let lettersMappings: [Mapping<Int, Character>] = [
        Mapping(from: 0, to: "A"), Mapping(from: 1, to: "B"), 
        Mapping(from: 2, to: "C"), Mapping(from: 3, to: "D"), 
        Mapping(from: 4, to: "E"), Mapping(from: 5, to: "F"), 
        Mapping(from: 6, to: "G"), Mapping(from: 7, to: "H"), 
        Mapping(from: 8, to: "I"), Mapping(from: 9, to: "J"),
        Mapping(from: 10, to: "K"), Mapping(from: 11, to: "L"), 
        Mapping(from: 12, to: "M"), Mapping(from: 13, to: "N"), 
        Mapping(from: 14, to: "O"), Mapping(from: 15, to: "P"), 
        Mapping(from: 16, to: "Q"), Mapping(from: 17, to: "R"), 
        Mapping(from: 18, to: "S"), Mapping(from: 19, to: "T"),
        Mapping(from: 20, to: "U"), Mapping(from: 21, to: "V"), 
        Mapping(from: 22, to: "W"), Mapping(from: 23, to: "X"), 
        Mapping(from: 24, to: "Y"), Mapping(from: 25, to: "Z"), 
        Mapping(from: 26, to: "_"), Mapping(from: 27, to: ".")
    ]
    
    func createMachine(withConfig config: MachineConfiguration) -> Remappable {
        let reflector = Reflector(withMappings: reflectorMappings)
        
        let rotors: Remappable = config.rotors.compactMap({
            RotorNumber(rawValue: $0) 
        }).reduce(reflector) {
            Rotor($1.mappings, nextMapper: $0) 
        }
        
        let plugBoard = Plugboard(withMappings: config.plugboardMappings, 
                                  nextMapper: rotors)
        plugBoard.shift(by: config.rotorSettings.reversed())
        
        return plugBoard
    }
    

    
}
