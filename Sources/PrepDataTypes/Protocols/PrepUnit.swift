import Foundation

public protocol DescribableUnit {
    var description: String { get }
    func description(for value: Double) -> String
    func description(isPlural: Bool) -> String
    func description(with amount: Double) -> String

    var shortDescription: String { get }
    func shortDescription(for value: Double) -> String
    func shortDescription(isPlural: Bool) -> String
    func shortDescription(with amount: Double) -> String
}

public extension DescribableUnit {
    
    func description(for value: Double) -> String {
        description(isPlural: value > 1)
    }

    func description(isPlural: Bool = false) -> String {
        isPlural ? description.plural : description
    }

    func shortDescription(for value: Double) -> String {
        shortDescription(isPlural: value > 1)
    }

    func shortDescription(isPlural: Bool = false) -> String {
        isPlural ? shortDescription.plural : shortDescription
    }
    
    func shortDescription(with amount: Double) -> String {
        amount.cleanedQuantity(unit: shortDescription(for: amount), amount: amount, lowercased: false)
    }
    
    func description(with amount: Double) -> String {
        amount.cleanedQuantity(unit: description(for: amount), amount: amount, lowercased: true)
    }
}

