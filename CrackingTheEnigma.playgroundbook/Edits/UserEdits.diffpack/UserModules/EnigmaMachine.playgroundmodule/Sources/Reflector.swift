import Foundation

// O refletor é o último objeto da cadeia.
// Ele sempre mapeará um inteiro para outro,
// nunca para ele mesmo e não rotaciona
class Reflector: Remappable {
    
    var nextMapper: Remappable?
    
    private var mappingsDict: [Int: Int] = [:]
    
    init(withMappings mappings: [Mapping<Int, Int>]) {
        for mapping in mappings {
            self.mappingsDict[mapping.from] = mapping.to
            self.mappingsDict[mapping.to] = mapping.from
        }
    }
    
    func remap(_ x: Int) -> Int {
        return self.mappingsDict[x] ?? -1
    }
    
    // O refletor é imóvel, não rotaciona
    func shift() { }
    func shift(by: [Int]) { }
    func reset() { }
}
