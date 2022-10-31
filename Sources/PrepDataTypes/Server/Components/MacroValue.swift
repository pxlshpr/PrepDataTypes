import Foundation

public struct MacroValue: Codable, Hashable {
    let macro: Macro
    let amount: Double
    
    public init(macro: Macro, amount: Double) {
        self.macro = macro
        self.amount = amount
    }
}
