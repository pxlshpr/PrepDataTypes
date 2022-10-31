import Foundation

public struct HeightMeasurement: Codable, Hashable {
    public let amount: Double
    public let heightUnit: HeightUnit
    public let timestamp: Int32
    
    public init(amount: Double, heightUnit: HeightUnit, timestamp: Int32) {
        self.amount = amount
        self.heightUnit = heightUnit
        self.timestamp = timestamp
    }
}

