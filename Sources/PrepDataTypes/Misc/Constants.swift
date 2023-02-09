import Foundation

public let KcalsPerGramOfFat = 8.75428571
public let KcalsPerGramOfCarb = 4.0
public let KcalsPerGramOfProtein = 4.0
public let KjPerKcal = 4.184

public let ErrorPercentageThresholdEnergyCalculation = 7.5

//TODO: Revisit these
/// RDA values for macros
public struct MacroRDA {
//    public static let protein = 50.0
    public static let protein = 80.0
    public static let carb = 78.0
    public static let fat = 275.0
}
