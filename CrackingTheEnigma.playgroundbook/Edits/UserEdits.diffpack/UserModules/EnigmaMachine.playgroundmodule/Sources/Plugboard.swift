import Foundation

class Plugboard: Remappable {
    var nextMapper: Remappable?

    private var mappingsDict: [Int: Int] = [:]
    
    init(withMappings mappings: [Mapping<Int, Int>], nextMapper: Remappable) {
        self.nextMapper = nextMapper
        
        for mapping in mappings {
            self.mappingsDict[mapping.from] = mapping.to
            self.mappingsDict[mapping.to] = mapping.from
        }
    }
    
    func remap(_ x: Int) -> Int {
        let destination = self.mappingsDict[x] ?? x
        if let nextMapperResult = self.nextMapper?.remap(destination) {
            self.nextMapper?.shift()
            return self.mappingsDict[nextMapperResult] ?? nextMapperResult
        } else {
            return -1
        }
    }

    func shift() { }

    func shift(by: [Int]) {
        self.nextMapper?.shift(by: by)
    }

    func reset() {
        self.nextMapper?.reset()
    }

}
