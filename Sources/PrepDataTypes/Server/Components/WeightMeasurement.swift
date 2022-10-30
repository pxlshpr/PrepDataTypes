import Foundation

public struct WeightMeasurement: Codable {
    public let amount: Double
    public let weightUnit: WeightUnit
    public let timestamp: Int32
    
    public init(amount: Double, weightUnit: WeightUnit, timestamp: Int32) {
        self.amount = amount
        self.weightUnit = weightUnit
        self.timestamp = timestamp
    }
}
