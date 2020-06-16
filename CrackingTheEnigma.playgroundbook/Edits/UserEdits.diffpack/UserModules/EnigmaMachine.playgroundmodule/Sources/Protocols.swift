import Foundation

// Refletor, rotores e plugboard
// serão chamados de Eixo e
// obedecer o protocolo de
// ramapeamento de valores
protocol Remappable {
    var nextMapper: Remappable? { get }
    
    func remap(_ x: Int) -> Int // pegamos um inteiro e passamos para outro
    func shift() // se for um rotor, ele mudará a cada caractere
    func shift(by: [Int]) // ""
    func reset() // se chegar ao final, voltará para o início
}

protocol MachineFactory {
    var lettersMappings: [Mapping<Int, Character>] { get }
    func createMachine(withConfig config: MachineConfiguration) -> Remappable
}

protocol ViewCode {
    func buildView()
    func setupConstraints()
    func setupAdditionalConfigs()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildView()
        setupConstraints()
        setupAdditionalConfigs()
    }
}
